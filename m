Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSGXKUm>; Wed, 24 Jul 2002 06:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316786AbSGXKUl>; Wed, 24 Jul 2002 06:20:41 -0400
Received: from 209-221-203-149.dsl.qnet.com ([209.221.203.149]:17925 "HELO
	divino.rinspin.com") by vger.kernel.org with SMTP
	id <S316608AbSGXKUl>; Wed, 24 Jul 2002 06:20:41 -0400
Message-ID: <34634.68.6.112.98.1027506178.squirrel@www.rinspin.com>
Date: Wed, 24 Jul 2002 03:22:58 -0700 (PDT)
Subject: Errors in 2.4.19-rc3 CML rules (SiS related)
From: "Scott Bronson" <bronson@rinspin.com>
To: linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.  I encountered some errors in the 2.4.19-rc3 CML rules.
It took a little while to track down, but I finally know what's
going on:

  1) CONFIG_DRM_SIS needs to require CONFIG_FB_SIS_315.
      Currently, you can select CONFIG_DRM_SIS without CONFIG_FB_SIS_315.
      If you do that, you get undefined symbol errors for sis_malloc and
         sis_free.

  2) CONFIG_FB_SIS must be compiled into the kernel (i.e. NOT a module).
      Currently, you can compile it as a module.
      If you do that, you ALSO get undefined symbol errors for
         sis_malloc and sis_free.

These requirements could be enforced with CML rules.  Before I
submit the patch to do this, I'd like to know if that's the proper
fix!  Would it be better to just make CONFIG_FB_SIS able to be built
as a module instead?

Thanks for any help.

    - Scott


