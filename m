Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131513AbQK3Iux>; Thu, 30 Nov 2000 03:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131448AbQK3Ium>; Thu, 30 Nov 2000 03:50:42 -0500
Received: from rvrplc-004.por.or.bbnow.net ([24.219.13.61]:9998 "HELO
        kroah.com") by vger.kernel.org with SMTP id <S131401AbQK3Iuc>;
        Thu, 30 Nov 2000 03:50:32 -0500
Date: Thu, 30 Nov 2000 00:17:01 -0800
From: Greg KH <greg@wirex.com>
To: "Mohammad A. Haque" <mhaque@haque.net>, linux-kernel@vger.kernel.org
Subject: Re: Keyspan USB PDA adapter && test12pre3 hang
Message-ID: <20001130001700.P19398@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001129234420.A7196@wirex.com>; from greg@wirex.com on
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Wed, Nov 29, 2000 at 11:44:20PM -0800
X-Operating-System: Linux 2.2.17-immunix (i686)

On Wed, Nov 29, 2000 at 11:44:20PM -0800, Greg KH wrote:
> If so, the following fix from Georg Acher should do the trick:
> 
> -----
> Replace line 275 (insert_td())
> qh->hw.qh.element = virt_to_bus (new) | UHCI_PTR_TERM;
> by
> qh->hw.qh.element = virt_to_bus (new) ;
> 
> -----

Here's the above in patch form to make it easier for people to apply.

greg k-h

-- 
greg@(kroah|wirex).com

--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="usb-uhci-2.4.0-test12-pre3.diff"

diff -Naur -X dontdiff linux-2.4.0-test12-pre3/drivers/usb/usb-uhci.c linux-2.4.0-test12-pre3-greg/drivers/usb/usb-uhci.c
--- linux-2.4.0-test12-pre3/drivers/usb/usb-uhci.c	Wed Nov 29 23:37:19 2000
+++ linux-2.4.0-test12-pre3-greg/drivers/usb/usb-uhci.c	Thu Nov 30 00:17:29 2000
@@ -272,7 +272,7 @@
 
 	if (qh == prev ) {
 		// virgin qh without any tds
-		qh->hw.qh.element = virt_to_bus (new) | UHCI_PTR_TERM;
+		qh->hw.qh.element = virt_to_bus (new);
 	}
 	else {
 		// already tds inserted, implicitely remove TERM bit of prev

--DBIVS5p969aUjpLe--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
