Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpGncOfQCw9adR9SN84JAsHkZmw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 04:45:31 +0000
Message-ID: <01a201c415a4$69dce2c0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
X-AuthUser: davidel@xmailserver.org
Date: Mon, 29 Mar 2004 16:42:16 +0100
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
From: "Davide Libenzi" <davidel@xmailserver.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: <Administrator@smtp.paston.co.uk>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
        <mingo@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040104043037.007922C0F1@lists.samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset="US-ASCII"
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:16.0828 (UTC) FILETIME=[69DF53C0:01C415A4]

On Sun, 4 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401031021280.1678-100000@bigblue.dev.mdolabs.com> you write:
> > Rusty, I took a better look at the patch and I think we can have 
> > per-kthread stuff w/out littering the task_struct and by making the thing 
> > more robust.
> 
> Except sharing data with a lock is perfectly robust.
> 
> > We keep a global list_head protected by a global spinlock. We 
> > define a structure that contain all the per-kthread stuff we need 
> > (including a task_struct* to the kthread itself). When a kthread starts it 
> > will add itself to the list, and when it will die it will remove itself 
> > from the list.
> 
> Yeah, I deliberately didn't implement this, because (1) it seems like
> a lot of complexity when using a lock and letting them share a single
> structure works fine and is even simpler, and (2) the thread can't
> just "do_exit()".
> 
> You can get around (2) by having a permenant parent "kthread" thread
> which is a parent to all the kthreads (it'll get a SIGCHLD when
> someone does "do_exit()").  But the implementation was pretty ugly,
> since it involved having a communications mechanism with the kthread
> parent, which means you have the global ktm_message-like-thing for
> this...

You will lose in any case. What happens if the thread does do_exit() and 
you do kthread_stop() after that?
With the patch I posted to you, the kthread_stop() will simply miss the 
lookup and return -ENOENT.



- Davide


