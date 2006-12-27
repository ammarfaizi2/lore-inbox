Return-Path: <linux-kernel-owner+w=401wt.eu-S1754721AbWL0VEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbWL0VEn (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754757AbWL0VEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:04:43 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:56059
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754721AbWL0VEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:04:43 -0500
From: Rob Landley <rob@landley.net>
To: Denis Vlasenko <vda.linux@googlemail.com>
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 16:03:38 -0500
User-Agent: KMail/1.9.1
Cc: ray-gmail@madrabbit.org, linux-kernel@vger.kernel.org,
       "David McCullough" <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <2c0942db0612262113v5b504aecmdd922193415b60de@mail.gmail.com> <200612271935.07835.vda.linux@googlemail.com>
In-Reply-To: <200612271935.07835.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271603.39454.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 1:35 pm, Denis Vlasenko wrote:
> This solves chroot problem. How to find path-to-yourself reliably
> (for one, without using /proc/self/exe) is not obvious to me.

Been there, done that.  Both my toybox and Firmware Linux projects do this.  
In FWL it's line 115 of this file:
http://landley.net/hg/firmware?f=937346748ff4;file=sources/toys/gcc-uClibc.c

It's essentially the logic of the command line "which" utility applied to 
argv[0].  If argv[0] has a relative or absolute path, then it's vs cwd (this 
has to happen when you first run the program, before you cd).  If argv[0] has 
no path then look at $PATH.

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
