Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136374AbREDN0J>; Fri, 4 May 2001 09:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136375AbREDNZ7>; Fri, 4 May 2001 09:25:59 -0400
Received: from ns.suse.de ([213.95.15.193]:35844 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136374AbREDNZs> convert rfc822-to-8bit;
	Fri, 4 May 2001 09:25:48 -0400
To: Keith Owens <kaos@ocs.com.au>
Cc: Todd Inglett <tinglett@vnet.ibm.com>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <8541.988980403@ocs3.ocs-net>
X-Yow: It's a lot of fun being alive...  I wonder if my bed is made?!?
From: Andreas Schwab <schwab@suse.de>
Date: 04 May 2001 15:11:37 +0200
In-Reply-To: <8541.988980403@ocs3.ocs-net> (Keith Owens's message of "Fri, 04 May 2001 22:46:43 +1000")
Message-ID: <jer8y52r92.fsf@hawking.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.103
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> writes:

|> On Fri, 04 May 2001 07:34:20 -0500, 
|> Todd Inglett <tinglett@vnet.ibm.com> wrote:
|> >But this is where hell breaks loose.  Every process has a valid parent
|> >-- unless it is dead and nobody cares.  Process N has already exited and
|> >released from the tasklist while its parent was still alive.  There was
|> >no reason to reparent it.  It just got released.  So N's task_struct has
|> >a dangling ptr to its parent.  Nobody is holding the parent task_struct,
|> >either.  When the parent died memory for its task_struct was released. 
|> >This is ungood.
|> 
|> Wrap the reference to the parent task structure with exception table
|> recovery code, like copy_from_user().

Exception tables only protect accesses to user virtual memory.  Kernel
memory references must always be valid in the first place.

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
