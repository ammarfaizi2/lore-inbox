Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131061AbQLQAKF>; Sat, 16 Dec 2000 19:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131080AbQLQAJz>; Sat, 16 Dec 2000 19:09:55 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:47869 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S131061AbQLQAJk>; Sat, 16 Dec 2000 19:09:40 -0500
Date: Sat, 16 Dec 2000 19:47:23 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: John Covici <covici@ccs.covici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too problem in 2.2.18
Message-ID: <20001216194723.E2049@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012161828180.628-100000@ccs.covici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012161828180.628-100000@ccs.covici.com>; from covici@ccs.covici.com on Sat, Dec 16, 2000 at 06:31:28PM -0500
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Dec 16, 2000 at 06:31:28PM -0500, John Covici escreveu:
> Hi.  I have a RealTech 8139 Ethernet card and I am using kernel
> 2.2.18.  I tried to use the new driver 8139too as a module, but when
> doing an insmod or modprobe on the module I got "symbol forparameter
> debug not found".  There was nothing obvious in the module source, so
> any assistance would be appreciated.

known bug, try this patch (adjust it to 2.2.18 if needed):

diff -dur linux-2.4.0-test12-clean/drivers/net/8139too.c linux-2.4.0-test12-fixed/drivers/net/8139too.c
--- linux-2.4.0-test12-clean/drivers/net/8139too.c      Sun Dec 10 12:55:42 2000
+++ linux-2.4.0-test12-fixed/drivers/net/8139too.c      Sun Dec 10 14:45:20 2000
@@ -74,6 +74,8 @@

                Tobias Ringström - Rx interrupt status checking suggestion

+               Gerard Sharp - bug fix for MODULE_PARM
+
        Submitting bug reports:

                "rtl8139-diag -mmmaaavvveefN" output
@@ -536,7 +538,9 @@
 MODULE_DESCRIPTION ("RealTek RTL-8139 Fast Ethernet driver");
 MODULE_PARM (multicast_filter_limit, "i");
 MODULE_PARM (max_interrupt_work, "i");
+#ifdef RTL8139_DEBUG
 MODULE_PARM (debug, "i");
+#endif /*RTL8139_DEBUG*/
 MODULE_PARM (media, "1-" __MODULE_STRING(8) "i");

 static int read_eeprom (void *ioaddr, int location, int addr_len);
diff -dur linux-2.4.0-test12-clean/fs/ntfs/fs.c linux-2.4.0-test12-fixed/fs/ntfs/fs.c


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
