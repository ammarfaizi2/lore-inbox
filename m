Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267365AbUJSWat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267365AbUJSWat (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 18:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269928AbUJSWYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 18:24:11 -0400
Received: from smtpout.mac.com ([17.250.248.97]:40166 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S269974AbUJSWUp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:20:45 -0400
In-Reply-To: <200410191613.35691.rmiller@duskglow.com>
References: <200410191613.35691.rmiller@duskglow.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1A4F78A9-221D-11D9-8195-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 2.6.9 DRM compile problem
Date: Tue, 19 Oct 2004 18:20:37 -0400
To: Russell Miller <rmiller@duskglow.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 19, 2004, at 17:13, Russell Miller wrote:
> Tried to compile 2.6.9 today.  Compiling DRM support appears to be 
> broken.
> I'm pretty sure that is not code that's expected to be broken.
>
> In file included from drivers/char/drm/gamma_drv.c:42:

Erm, due to massive macro cleanups in the DRM code:

diff -Nru a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/Kconfig	Fri Sep  3 20:29:48 2004
@@ -24,7 +24,7 @@

  config DRM_GAMMA
  	tristate "3dlabs GMX 2000"
-	depends on DRM
+	depends on DRM && BROKEN
  	help
  	  This is the old gamma driver, please tell me if it might actually
  	  work.

The gamma driver was broken to restore the sanity of DRM.  In
fact, the only way to actually even try to build it is to turn on the
config option "Include incomplete/broken drivers"

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


