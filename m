Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293461AbSB1QDl>; Thu, 28 Feb 2002 11:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293441AbSB1QBb>; Thu, 28 Feb 2002 11:01:31 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:50498 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293452AbSB1P7w>; Thu, 28 Feb 2002 10:59:52 -0500
Date: Thu, 28 Feb 2002 10:59:38 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: thread groups bug?
Message-ID: <20020228105938.H8011@redhat.com>
In-Reply-To: <bcrl@redhat.com> <2961.1014910587@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <2961.1014910587@warthog.cambridge.redhat.com>; from dhowells@redhat.com on Thu, Feb 28, 2002 at 03:36:27PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2002 at 03:36:27PM +0000, David Howells wrote:
> > How about: (3) make execve allocate a new thread group id?
> 
> It seems that the TGID must also be a valid PID so that signal handling will
> work correctly...
> 
> This could be solved by making PIDs independent of processes, but that's
> really not very nice.

Oh, interesting.  Note that we already allocate from the pid space for 
other things, so it's entirely doable.  Another choice would be to simply 
disallow the thread group leader from exec'ing.  Linux threads traditionally 
try to remain as close to process behaviour as possible, and allowing an 
individual thread to exec is very useful, so I'm still in favour of 
allocating a new tgid.

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
