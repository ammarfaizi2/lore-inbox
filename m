Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287552AbSBLTMu>; Tue, 12 Feb 2002 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBLTMl>; Tue, 12 Feb 2002 14:12:41 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:35034 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S287552AbSBLTMa>;
	Tue, 12 Feb 2002 14:12:30 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15465.26907.618278.388730@napali.hpl.hp.com>
Date: Tue, 12 Feb 2002 11:12:27 -0800
To: David Howells <dhowells@redhat.com>
Cc: davidm@hpl.hp.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Task ornaments
In-Reply-To: <23542.1013512554@warthog.cambridge.redhat.com>
In-Reply-To: <davidm@hpl.hp.com>
	<15464.24083.54161.609609@napali.hpl.hp.com>
	<23542.1013512554@warthog.cambridge.redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 12 Feb 2002 11:15:54 +0000, David Howells <dhowells@redhat.com> said:

  David.H> Well, I've been using them in two ways to date, without
  David.H> much of a problem.

Well, that's my point.  This kind of stuff works great until you
start to really push it.

  David.H> The biggest problem I've seen is with
  David.H> signal cancellation/alteration by the signal delivery
  David.H> callback on an ornament, since that affects what signal
  David.H> (and if) the next ornament sees.

Yup.  And that's only the beginning.  I bet the perfmon support would
introduce even more interesting ordering constraints.

  David.H> There are two further callbacks I have thought about
  David.H> adding:

  David.H>  (1) Subsumation of the pending signal-notifier stuff
  David.H> currently in the task_struct (used by DRM). However, this
  David.H> means the the sigmask_lock must be held any time you want
  David.H> to walk or change the task ornament list:-/

  David.H>  (2) CPU user exception notification(s). Give task
  David.H> ornaments a chance to handle these in a way more
  David.H> appropriate to the binfmt or personality of the process
  David.H> (for instance, to generate a Win32 structured exception).

  David.H>      However, I think this is probably superfluous given
  David.H> the provision of the signal delivery notification.

  David.H> There are also a number of other things I've thought about
  David.H> trying to do with task ornaments, though I'm not sure of
  David.H> how practical they are. The only one I can actually think
  David.H> of at the moment, though, is:

  David.H>  (1) Child process notifying parent (and other processes)
  David.H> on death (basically the SIGCHLD handler). This would allow
  David.H> this bit of code to be removed from the exit path. A parent
  David.H> process would install an ornament in each child process's
  David.H> list and would remove them when the parent died. This might
  David.H> make thread handling somewhat easier, as signals could then
  David.H> be easily redirected.

Basically, you're proving my point.  Ornaments look like a generic
facility, yet there are global dependencies (ordering, locking, ...)
which require each use to be checked against possibly all existing
ornament users.

	--david
