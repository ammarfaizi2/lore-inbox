Return-Path: <linux-kernel-owner+w=401wt.eu-S964846AbXADNK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964846AbXADNK2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbXADNK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:10:27 -0500
Received: from web36709.mail.mud.yahoo.com ([209.191.85.43]:45880 "HELO
	web36709.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S964846AbXADNK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:10:27 -0500
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 08:10:26 EST
Message-ID: <20070104125014.2640.qmail@web36709.mail.mud.yahoo.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=5LX+PQGmzN/KsUbcOYYN2c78V+hl9x/d+KSGyXEJhsJ6ytsyIpqfjkMCuB2RT6cQGVgBC/uWUPdV/wA0ELwQ1hHBf1JbHbr+7MGJS7YrbIEMCkpay/I2mMUZl6O86OEguN+dyGvWIKB5cnrDjIT+KiyG1eJ3cOzNkz6dlJ2nvTo=;
X-YMail-OSG: d7yjTcsVM1k1951AhIQMZMqDAyG4OAXKu6o.IAOJqu.DRqcj0y7emS2lDbqrkTpmLfV_LCqBVB71Z7L8HI2UlGSQ2dTsA9VGlXLof5QStBw7E.zoJrGwuLgjc3qbHa2qdUO_pVJjaYMpMQ--
Date: Thu, 4 Jan 2007 04:50:14 -0800 (PST)
From: Alex Dubov <oakad@yahoo.com>
Subject: Re: [PATCH 2.6.19] mmc: Add support for SDHC cards (Take 2)
To: Philip Langdale <philipl@overt.org>, Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <459C8FA4.7080709@overt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the trivial fix will do (after all, there's nothing that should matter to the controller
in the R6 response; I don't know about R7). I don't have any SDHC cards so I can't test this.

--- tifm_sd.c.orig      2006-12-11 01:39:28.000000000 +1100
+++ tifm_sd.c   2007-01-04 23:40:48.441724000 +1100
@@ -179,6 +179,8 @@
        case MMC_RSP_R1B:
                rc |= TIFM_MMCSD_RSP_BUSY; // deliberate fall-through
        case MMC_RSP_R1:
+       case MMC_RSP_R6:
+       case MMC_RSP_R7:
                rc |= TIFM_MMCSD_RSP_R1;
                break;
        case MMC_RSP_R2:
@@ -187,9 +189,6 @@
        case MMC_RSP_R3:
                rc |= TIFM_MMCSD_RSP_R3;
                break;
-       case MMC_RSP_R6:
-               rc |= TIFM_MMCSD_RSP_R6;
-               break;
        default:
                BUG();
        }


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
