Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265143AbUAPPOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 10:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265156AbUAPPOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 10:14:17 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:19623 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S265143AbUAPPOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 10:14:15 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16391.65470.831998.936394@laputa.namesys.com>
Date: Fri, 16 Jan 2004 18:14:06 +0300
To: Joe Thornber <thornber@redhat.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Prashanth T <prasht@in.ibm.com>,
       rml@tech9.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwlock_is_locked undefined for UP systems
In-Reply-To: <20040116145311.GD1740@reti>
References: <4007EAE7.2030104@in.ibm.com>
	<1074261350.4434.4.camel@laptop.fenrus.com>
	<20040116145311.GD1740@reti>
X-Mailer: VM 7.17 under 21.5  (beta16) "celeriac" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Thornber writes:
 > On Fri, Jan 16, 2004 at 02:55:50PM +0100, Arjan van de Ven wrote:
 > > On Fri, 2004-01-16 at 14:45, Prashanth T wrote:
 > > > Hi,
 > > >     I had to use rwlock_is_locked( ) with linux2.6 for kdb and noticed that
 > > > this routine to be undefined for UP.  I have attached the patch for 2.6.1
 > > > below to return 0 for rwlock_is_locked( ) on UP systems.
 > > > Please let me know.
 > > 
 > > I consider any user of this on UP to be broken, just like UP use of
 > > spin_is_locked() is always a bug..... better a compiletime bug than a
 > > runtime bug I guess...
 > 
 > Then maybe a #error explaining this is in order ?

So, if there is a function

void foo_locked(struct bar *obj)
{
    /* check that we are called with obj's lock held */
    BUG_ON(!rwlock_is_locked(&obj->lock));
    /* proceed with obj. */
}

it should now be changed to the

void foo_locked(struct bar *obj)
{
#ifdef CONFIG_SMP
    BUG_ON(!rwlock_is_locked(&obj->lock));
#endif
    /* proceed with obj. */
}

?

 > 
 > - Joe
 > 

Nikita.

 > 
