Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbUCJLnG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 06:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUCJLnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 06:43:06 -0500
Received: from ns.bitdefender.com ([217.156.83.1]:47296 "EHLO avxfw.softwin.ro")
	by vger.kernel.org with ESMTP id S262583AbUCJLnA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 06:43:00 -0500
X-BitDefender-Spam: No (0)
X-BitDefender-Scanner: Clean, Agent: Qmail 1.5.6 (mail.dsd.ro)
Date: Wed, 10 Mar 2004 13:42:52 +0200
From: "Viorel Canja, Softwin" <vcanja@bitdefender.com>
X-Mailer: The Bat! (v2.00)
Reply-To: "Viorel Canja, Softwin" <vcanja@bitdefender.com>
Organization: Softwin
X-Priority: 3 (Normal)
Message-ID: <1487103774.20040310134252@bitdefender.com>
To: Paul Wagland <paul@wagland.net>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re[2]: problem in tcp_v4_synq_add ?
In-Reply-To: <F750F6B1-7271-11D8-AFFE-000A95CD704C@wagland.net>
References: <684501482.20040309132741@bitdefender.com>
 <20040309113046.40271dc8.davem@redhat.com>
 <F750F6B1-7271-11D8-AFFE-000A95CD704C@wagland.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

This comment in sock.h makes things clearer :

397         /* The syn_wait_lock is necessary only to avoid tcp_get_info having
398          * to grab the main lock sock while browsing the listening hash
399          * (otherwise it's deadlock prone).
400          * This lock is acquired in read mode only from tcp_get_info() and
401          * it's acquired in write mode _only_ from code that is actively
402          * changing the syn_wait_queue. All readers that are holding
403          * the master sock lock don't need to grab this lock in read mode
404          * too as the syn_wait_queue writes are always protected from
405          * the main sock lock.
406          */


best regards,
Viorel

Wednesday, March 10, 2004, 11:04:41 AM, you wrote:


PW> On Mar 9, 2004, at 20:30, David S. Miller wrote:

>> On Tue, 9 Mar 2004 13:27:41 +0200
>> "Viorel Canja, Softwin" <vcanja@bitdefender.com> wrote:
>>
>>> Shouldn't  "write_lock(&tp->syn_wait_lock);" be moved before
>>> "req->dl_next = lopt->syn_table[h];" to avoid a race condition ?
>>
>> Nope, the listening socket's socket lock is held, and all things that
>> add members to these hash chains hold that lock.

PW> Is that the same as saying that the write_lock() is not needed at all?
PW> Since it is already guaranteed to be protected with a different lock?

PW> Cheers,
PW> Paul


