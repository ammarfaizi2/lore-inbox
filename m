Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964830AbWHCS0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWHCS0h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbWHCS0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:26:37 -0400
Received: from iona.labri.fr ([147.210.8.143]:24036 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S964830AbWHCS0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:26:36 -0400
Date: Thu, 3 Aug 2006 20:26:34 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix initialization of runqueues
Message-ID: <20060803182634.GD4368@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20060802122743.GF4460@implementation.labri.fr> <20060802152419.GA31970@elte.hu> <20060802165742.GI4460@implementation.labri.fr> <1154617657.32264.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1154617657.32264.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt, le Thu 03 Aug 2006 11:07:37 -0400, a écrit :
> On Wed, 2006-08-02 at 18:57 +0200, Samuel Thibault wrote:
> > Ingo Molnar, le Wed 02 Aug 2006 17:24:19 +0200, a écrit :
> > > 
> > > * Samuel Thibault <samuel.thibault@ens-lyon.org> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > There's an odd thing about the nr_active field in arrays of 
> > > > runqueue_t: it is actually never initialized to 0!...  This doesn't 
> > > > yet trigger a bug probably because the way runqueues are allocated 
> > > > make it so that it is already initialized to 0, but that's not a safe 
> > > > way.  Here is a patch:
> > > 
> > > we do rely on zero initialization of bss (and percpu) data in a number 
> > > of places.
> > 
> > The rest of runqueue initialization doesn't rely on that, and as
> > a result people might think that it is safe to allocate runqueues
> > dynamically.
> 
> I don't buy the "safe to allocate runqueues dynamically" bit since they
> are local to sched.c and if you do do that (I did for a customer once)
> you better know what you're doing.

Yes, but as you agreed, initializing some members to 0 and not others
doesn't help to know what you're doing :)

Samuel
