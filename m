Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272237AbRHWJMI>; Thu, 23 Aug 2001 05:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272234AbRHWJL6>; Thu, 23 Aug 2001 05:11:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:63502 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S272238AbRHWJLx>; Thu, 23 Aug 2001 05:11:53 -0400
Date: Thu, 23 Aug 2001 06:12:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "Jens Hoffrichter" <HOFFRICH@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Allocation of sk_buffs in the kernel
Message-ID: <20010823061206.U5062@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"Jens Hoffrichter" <HOFFRICH@de.ibm.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <OF451110AC.14EEC1A3-ONC1256AB1.0030B2FB@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <OF451110AC.14EEC1A3-ONC1256AB1.0030B2FB@de.ibm.com>; from HOFFRICH@de.ibm.com on Thu, Aug 23, 2001 at 11:01:42AM +0200
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2001 at 11:01:42AM +0200, Jens Hoffrichter escreveu:
> Hi,
> 
> > Maybe Jens should use something like WAITQUEUE_DEBUG if he want to know
> > where alloc_skb and friends were called, see include/linux/wait.h 8)
> Do you mean I should use something LIKE the WAITQUEUE_DEBUG (eg.
> implementing something like that in skbuff.c) or I should use
> WAITQUEUE_DEBUG?

no, just use the same idea that is used to debug wait_queues
 
> The code in wait.h mainly seems to consist of issuing BUG() calls, and
> thats not quite what I want to ;) But how is it to use? I don't know much
> about waitqueues in the Linux kernel, I mainly played with the network
> stack...

heh, thats my use for the waitqueue debug now 8)
 
> Are there any examples how to use the WAITQUEUE_DEBUG?

oops, I mean the __waker thing, for debugging you could get the address of
the caller with current_text_addr() and store it in an extra sk_buff field
so that later on you could know who create the skb.

About the example of WAITQUEUE_DEBUG:

after being awaken you could do this:

                dprintk("sleeper=%p, waker=%lx\n",
                         current_text_addr(), wait.__waker);

in a inline function does the trick, but this is just an example of a
function that uses an extra debug field in a structure that is alocated
somewhere and you want to know who allocated it later on.

Yes, you'll have to decode the address from syslog, gotcha?

- Arnaldo

