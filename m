Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030319AbWGMTfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWGMTfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbWGMTfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:35:44 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:64412 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030319AbWGMTfm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:35:42 -0400
Date: Thu, 13 Jul 2006 21:35:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Matthew Wilcox <matthew@wil.cx>, wookey@debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support DOS line endings
Message-ID: <20060713193543.GB312@mars.ravnborg.org>
References: <20060707173458.GB1605@parisc-linux.org> <Pine.LNX.4.64.0607080513280.17704@scrub.home> <20060713181825.GA22895@mars.ravnborg.org> <Pine.LNX.4.64.0607132039560.12900@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607132039560.12900@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2006 at 08:47:12PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Thu, 13 Jul 2006, Sam Ravnborg wrote:
> 
> > >       if (p2[-1] == '\r')
> > >               p2[-1] = 0;
> > Negative index'es always make me supsicious.
> 
> Opencoding of the strchr is not much better, you can change the above also 
> to (*--p2 == '\r').
There is no semantic difference between decrementing a variable and a
negative index.
But I used this one anyway.
So now it look like this.

	Sam

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index a69d8ac..b7e7281 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -195,6 +195,8 @@ load:
 			p2 = strchr(p, '\n');
 			if (p2)
 				*p2 = 0;
+			if (*--p2 == '\r')
+				*p2 = 0;
 			if (def == S_DEF_USER) {
 				sym = sym_find(line + 7);
 				if (!sym) {
@@ -266,6 +268,7 @@ load:
 				;
 			}
 			break;
+		case '\r':
 		case '\n':
 			break;
 		default:
