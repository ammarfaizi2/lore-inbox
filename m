Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbVKAOIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbVKAOIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 09:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVKAOIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 09:08:09 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:40584 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750794AbVKAOII (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 09:08:08 -0500
Message-ID: <436776C6.3040900@free.fr>
Date: Tue, 01 Nov 2005 15:08:06 +0100
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
References: <4363F9B5.6010907@free.fr> <20051031155803.2e94069f.akpm@osdl.org>
In-Reply-To: <20051031155803.2e94069f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

thanks for the review.

Andrew Morton wrote:
> matthieu castet <castet.matthieu@free.fr> wrote:
> 

>>...
>>+static int request_cmvs(struct uea_softc *sc,
>>+		 struct uea_cmvs **cmvs, const struct firmware **fw)
>>+{
>>+	int ret, size;
>>+	u8 *data;
>>+	char *file;
>>+	char cmv_name[256] = FW_DIR;
> 
> 
> That's rather a lot of stack.  Can this be made static, of kmalloced?
> 
> 
I think we'll made it static.

>>+
>>+	*cmvs = (struct uea_cmvs *)(data + 1);
> 
> 
> That's a bit rude - asking the compiler to perform a structure copy from an
> odd address.  memcpy() would be saner.
> 
Could you elaborate a bit more ?
I don't see where there is a copy.
*cmvs is a pointer to the structure, not the structure. And when we 
parse the structure, we use get_unaligned functions.


>>...
>>+/**
>>+ * uea_read_proc : /proc information
>>+ */
>>+static int uea_read_proc(char *page, 
>>+		char **start, off_t off, int count, int *eof, void *data)
> 
> 
> People get shouted at for adding /proc handlers.  Greg may have thoughts...
> 
Ok, we may be convert some values to sysfs. It would be nice if usbatm 
allow us to export some common value (margin, ...).


Matthieu
