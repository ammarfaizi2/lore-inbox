Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262960AbVCXAAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbVCXAAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVCXAAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:00:30 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:41351 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262954AbVCWX7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:59:48 -0500
Date: Wed, 23 Mar 2005 17:59:36 -0600
From: Michael Raymond <mraymond@sgi.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User Level Interrupts
Message-ID: <20050323175935.A272763@xanatos.americas.sgi.com>
References: <20050323103832.A108873@goliath.americas.sgi.com> <20050323145738.A29828@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050323145738.A29828@unix-os.sc.intel.com>; from ashok.raj@intel.com on Wed, Mar 23, 2005 at 02:57:39PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Once the ULI code has taken over a CPU, it should not be rescheduable
until the ULI completes.  The goal is a very fast jump in and out of user
space.  Primitives are provided for the waking of another thread / process
if the applications needs to do a lot of work.
    If I've left open the possibility of a reschedule, then it was a design
error.  As I think about it though everything should still work fine, but
it's purely by accident. :)
    If you have test code for hotplug I'd be happy to test it for you.
       	   	     	      	      	     Thanks,
					     	    Michael

On Wed, Mar 23, 2005 at 02:57:39PM -0800, Ashok Raj wrote:
> Hi Michael
> 
> have you thought about how this infrastructure would play well with 
> existing CPU hotplug code for ia64?
> 
> Once you return to user mode via the iret, is it possible that user mode
> thread could get switched due to a pending cpu quiese attempt to remove
> a cpu? (Current cpu removal code would bring the entire system to knees
> by scheduling a high priority thread and looping with intr disabled, until the
> target cpu is removed)
> 
> the cpu removal code would also attempt to migrate user process to another cpu,
> retarget interrupts to another existing cpu etc. I havent tested the hotplug
> code on sgi boxes so far. (only tested on some hp boxes by Alex Williamson
> and on tiger4 boxes so far)
> 
> Cheers,
> ashok

-- 
Michael A. Raymond              Office: (651) 683-3434
Core OS Group                   Real-Time System Software
