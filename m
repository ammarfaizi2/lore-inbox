Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSEUXzU>; Tue, 21 May 2002 19:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316793AbSEUXzT>; Tue, 21 May 2002 19:55:19 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:20206 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S316792AbSEUXzT>; Tue, 21 May 2002 19:55:19 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.56920.643114.961122@wombat.chubb.wattle.id.au>
Date: Wed, 22 May 2002 09:55:04 +1000
To: Andi Kleen <ak@suse.de>
Cc: Dave McCracken <dmccr@us.ibm.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [RFC] POSIX personality
In-Reply-To: <187597808@toto.iv>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: .slVUC18R`%{j(W3ztQe~*ATzet;h`*Wv33MZ]*M,}9AP<`+C=U)c#NzI5vK!0^d#6:<_`a
 {#.<}~(T^aJ~]-.C'p~saJ7qZXP-$AY==]7,9?WVSH5sQ}g3,8j>u%@f$/Z6,WR7*E~BFY.Yjw,H6<
 F.cEDj2$S:kO2+-5<]afj@kC!:uw\(<>lVpk)lPZs+2(=?=D/TZPG+P9LDN#1RRUPxdX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

Andi> Dave McCracken <dmccr@us.ibm.com> writes:
>> --On Tuesday, May 21, 2002 01:52:37 PM -0700 Linus Torvalds
>> <torvalds@transmeta.com> wrote:
>> 
>> > I don't see any reason to start using some fixed-mode semantics
>> without > seeing some stronger arguments on exactly why that would
>> be a good idea. > We have used up 11 of 24 bits (and more can be
>> made available) over the > last five years, and there are no
>> obvious inefficiencies that I can see.
>> 
>> Ok, sounds reasonable.  I'll add the bits as I go, then.

Andi> One reason for it would be that it would be more efficient. All
Andi> the various shared state needed for POSIX thread group emulation
Andi> could be put into a single structure with a single reference
Andi> count.

Andi> With clone flags you need one pointer in task_struct per flag
Andi> and handling of the reference count for each data structure and
Andi> allocation/freeing from various slabs for a real fork.
Andi> (basically lots of atomic operations at fork time + bloating of
Andi> task_struct)


With one minor restriction, you could do it the same way SGI's IRIX
handled sproc() --- have a   struct shared   that was pointed to by the
task structure, that was then partially or completely populated
depending on the sharing flags.  The   struct shared   can also have a
list of tasks that share stuff in it.  Each task has a set of flags to
say what's being shared.

You'd have to disallow sharing things that a task's parent doesn't
share with the task, if the parent and the child are part of the same
share group. 

Peter C
