Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261668AbTCaObe>; Mon, 31 Mar 2003 09:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261672AbTCaObe>; Mon, 31 Mar 2003 09:31:34 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:8599 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S261668AbTCaObC>; Mon, 31 Mar 2003 09:31:02 -0500
Date: Mon, 31 Mar 2003 16:42:15 +0200
From: Stelian Pop <stelian@popies.net>
To: "Daniel K." <dk@uw.no>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] fix ec_read using wrong #define's in sonypi driver.
Message-ID: <20030331164215.D11090@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>, "Daniel K." <dk@uw.no>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <3E884305.9070701@uw.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E884305.9070701@uw.no>; from dk@uw.no on Mon, Mar 31, 2003 at 01:30:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 01:30:45PM +0000, Daniel K. wrote:

> This patch will make the driver use the correct #define's when
> querying battery charge.
> 
> This error sneaked into 2.4.20-pre1,
> and have been present in 2.5 since 2.5.49.

Damn, a copy and paste error and nobody noticed until now.

Thanks Daniel!

Linus, Marcelo, please apply it.

Stelian.

--- linux-2.4.21-pre6.vanilla/drivers/char/sonypi.c	2003-03-29 17:27:22.000000000 +0000
+++ linux-2.4.21-pre6/drivers/char/sonypi.c	2003-03-30 11:44:42.000000000 +0000
@@ -531,7 +531,7 @@
  			ret = -EFAULT;
  		break;
  	case SONYPI_IOCGBAT1REM:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT1_LEFT, &val16)) {
  			ret = -EIO;
  			break;
  		}
@@ -539,7 +539,7 @@
  			ret = -EFAULT;
  		break;
  	case SONYPI_IOCGBAT2CAP:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT2_FULL, &val16)) {
  			ret = -EIO;
  			break;
  		}
@@ -547,7 +547,7 @@
  			ret = -EFAULT;
  		break;
  	case SONYPI_IOCGBAT2REM:
-		if (ec_read16(SONYPI_BAT1_FULL, &val16)) {
+		if (ec_read16(SONYPI_BAT2_LEFT, &val16)) {
  			ret = -EIO;
  			break;
  		}


-- 
Stelian Pop <stelian@popies.net>
