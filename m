Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132097AbQK0AAo>; Sun, 26 Nov 2000 19:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S133072AbQK0AAe>; Sun, 26 Nov 2000 19:00:34 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:23036 "EHLO ylenurme.ee")
        by vger.kernel.org with ESMTP id <S132097AbQK0AA2>;
        Sun, 26 Nov 2000 19:00:28 -0500
Date: Mon, 27 Nov 2000 01:30:06 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: linux-kernel@vger.kernel.org
Subject: Universal debug macros.
In-Reply-To: <200011262249.XAA10540@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.10.10011270109020.11180-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2000, Rogier Wolff wrote:
> Sure it will slow the driver down a bit, because of all those bit-test
> instructions in the driver. If it bothers you, you get to turn it
> off. If you are capable of that, you are also capable enough to turn
> it back on when neccesary.

Now if there would be simple _unified_ system for switching debug code
on/off, it would be a real win. That  recompilation-capable enduser would
not need much knowledge to go "General Setup" or newly created
"Optimization" section and switch debugging off/on for _all_ network
drivers or ide drivers for example.


> The debug asserts that trigger during normal operation are what make
> the Linux kernel stable. Problems get spotted at an early
> stage. Problems get fixed.

Yess


Lets say LDBG_* namespace, 
macros being in general form:
 LDBG_OPERATION(OPTIMIZATION_LEVEL,SUBSYSTEM,MODULE,ACTION, operation params..)

OPERATIONS would be first likely:
	ASSERT_PRINT, PRINT, ASSERT_PANIC

OPTIMIZATION_LEVELs would be first:
	DEVELOP, ALPHA, BETA, TEST, RELEASE, PRODUCTION, FINETUNED, EMBEDDED 

SUBSYSTEMS:
	memory, fs, network, drivers(network, fs,...), 
	divided to about 20 sections or so.
MODULE: would be current module

ACTION: division inside module :
	DATA_UP, DATA_DOWN, INIT, CLEANUP, CONFIGURE, ToUserpace,FromUserSpace
	... etc. about 15-25 divisions.

LDBG_DECLARE_DEBUG_VAR(OPTIMIZATION_LEVEL, SUBSYSTEM, MODULE)
woudl declare a global unsigned int subsystem_module_debug = 0 and
also sysctl interface to change it.
the var would have ACTION bitfields, so user can control debug output
runtime for the module.


elmer.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
