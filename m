Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293053AbSCRVtQ>; Mon, 18 Mar 2002 16:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293048AbSCRVtH>; Mon, 18 Mar 2002 16:49:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14568 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293053AbSCRVtA>;
	Mon, 18 Mar 2002 16:49:00 -0500
Message-ID: <3C96609C.30987A95@us.ibm.com>
Date: Mon, 18 Mar 2002 13:48:12 -0800
From: Larry Kessler <kessler@us.ibm.com>
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Tony.P.Lee@nokia.com
CC: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, kessler@us.ibm.com
Subject: Re: [PATCH-RFC] POSIX Event Logging, kernel 2.5.6 & 2.4.18y
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A2037@mvebe001.NOE.Nokia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony.P.Lee@nokia.com wrote:
> How about this?
> 
> int printk_improve(const char* filename, int line_no,
>         const char* function_name, int module_buf_idx, ...);
> 
> #define printk(PRINTF_ARGS...) \
>         printk_improve(__FILE__, __LINE__, __FUNCTION__, \
>                 CUR_MODULE_BUF_IDX, ##PRINTF_ARGS);

When printk is defined as a macro...
"directives may not be used inside a macro argument"
...is the error caused by this style of coding:

   printk("generic options"
#ifdef AUTOPROBE_IRQ
	"AUTOPROBE_IRQ"
#else
	"AUTOSENSE"
#endif
	);

In the 2.5.6 kernel, the complete list of source files 
with directives inside the printk arg list:
drivers/net/tulip/de4x5.c
drivers/net/de620.c
drivers/net/de600.c
drivers/net/slip.c
drivers/scsi/oktagon_esp.c
drivers/scsi/sun3_NCR5380.c
drivers/scsi/sym53c8xx.c
drivers/scsi/NCR5380.c
drivers/scsi/mac_NCR5380.c
drivers/scsi/ncr53c8xx.c
drivers/scsi/seagate.c
drivers/scsi/atari_scsi.c
drivers/scsi/atari_NCR5380.c
drivers/s390/s390io.c
arch/ppc/8xx_io/fec.c
arch/alpha/kernel/setup.c
arch/s390x/kernel/setup.c
arch/s390/kernel/setup.c
sound/oss/msnd_pinnacle.c
fs/ntfs/fs.c

It is possible to submit patches to all of the maintainers
explaining that we wish to collect a standard set of info
with each call to printk, so please accept this patch, but
is it reasonable to prohibit this coding style ?  

On a related note, there are 554 #defines in the kernel that
contain "printk" in the first line, so there is some
customization going on already.
