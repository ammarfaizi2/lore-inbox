Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266952AbTGGLdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266953AbTGGLdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:33:02 -0400
Received: from [213.39.233.138] ([213.39.233.138]:10393 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266952AbTGGLc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:32:59 -0400
Date: Mon, 7 Jul 2003 13:46:42 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Paul Mackerras <paulus@samba.org>
Cc: benh@kernel.crashing.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH 2.5.73] Signal stack fixes #1 introduce PF_SS_ACTIVE
Message-ID: <20030707114642.GA7104@wohnheim.fh-wedel.de>
References: <20030703202410.GA32008@wohnheim.fh-wedel.de> <20030704174339.GB22152@wohnheim.fh-wedel.de> <20030704174558.GC22152@wohnheim.fh-wedel.de> <20030704175439.GE22152@wohnheim.fh-wedel.de> <16134.2877.577780.35071@cargo.ozlabs.ibm.com> <20030705073946.GD32363@wohnheim.fh-wedel.de> <16135.57910.936187.611245@cargo.ozlabs.ibm.com> <20030706101754.GA23341@wohnheim.fh-wedel.de> <16137.23193.530130.847522@nanango.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16137.23193.530130.847522@nanango.paulus.ozlabs.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 July 2003 21:33:45 +1000, Paul Mackerras wrote:
> 
> It just occurred to me that the simplest and best fix for the specific
> problem you mention is for you to set the SA_ONESHOT flag when you
> install the SIGSEGV handler.  That way, if you get another
> segmentation violation while you are already in the SIGSEGV handler,
> it will just dump core straight away.

That makes sense.  One would still have to re-enable the signal
handler inside the signal handler, but if htat is the last code before
function return, we should be safe.

Great idea, thanks!

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
