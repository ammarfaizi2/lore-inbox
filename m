Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265922AbRF2Pcu>; Fri, 29 Jun 2001 11:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbRF2Pck>; Fri, 29 Jun 2001 11:32:40 -0400
Received: from mozart.stat.wisc.edu ([128.105.5.24]:21255 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S265997AbRF2Pc3>; Fri, 29 Jun 2001 11:32:29 -0400
To: Michael J Clark <clarkmic@pobox.upenn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP stack
In-Reply-To: <200106281433.f5SEXk800876@pobox.upenn.edu>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Michael J Clark's message of "Thu, 28 Jun 2001 10:33:46 -0400 (EDT)"
Date: 29 Jun 2001 10:32:21 -0500
Message-ID: <vbau20z9u9m.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael J Clark <clarkmic@pobox.upenn.edu> writes:
> 
> I have been reading through TCP/IP Illustrated Vol 2 and the linux 
> source.  I am having a heck of a time finding where it sees a SYN packet 
> and check to see if the desitination port is open.  In the book it looks 
> like it happens in tcp_input where it looks for the PCB for a segment.  
> Any pointers would be greatly appeciated.

In 2.2.19 (since I have the source handy), this processing is done in
"linux/net/ipv4/tcp_input.c" in function "tcp_rcv_state_process".  If
a SYN packet arrives and the socket is in state TCP_LISTEN, the
address-family-specific "conn_request" function is called.  For IPv4,
this is "tcp_v4_conn_request" in "tcp_ipv4.c".

On the other hand, if a SYN packet is sent to a TCP_CLOSE socket,
"tcp_rcv_state_process" returns 1.  This is an indication to the
caller ("tcp_v4_do_rcv" in "tcp_ipv4.c", in the case of IPv4) to send
a RST packet.

Kevin <buhr@stat.wisc.edu>
