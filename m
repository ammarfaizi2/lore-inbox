Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135463AbRDRX5F>; Wed, 18 Apr 2001 19:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135481AbRDRX44>; Wed, 18 Apr 2001 19:56:56 -0400
Received: from mail.ettnet.se ([212.109.4.7]:41741 "HELO mail.ettnet.se")
	by vger.kernel.org with SMTP id <S135463AbRDRX4k>;
	Wed, 18 Apr 2001 19:56:40 -0400
Date: Thu, 19 Apr 2001 04:06:18 +0200
From: Joel Eriksson <jen@ettnet.se>
To: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Socket hack question.
Message-ID: <20010419040617.B8366@seth>
In-Reply-To: <20010419030315.A7923@seth> <Pine.LNX.4.10.10104181931310.14361-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104181931310.14361-100000@coffee.psychology.mcmaster.ca>; from hahn@coffee.psychology.mcmaster.ca on Wed, Apr 18, 2001 at 07:31:55PM -0400
X-Phone: +46-736-256517
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2001 at 07:31:55PM -0400, Mark Hahn wrote:
> > post. :-) But I thought sendfile() could only be used for sending data
> > from a "regular" file descriptor to another file- or socket descriptor..?
> 
> he said the syscall (ie, interface) already existed,
> not that it was implemented how you want it.

Well, that's right, I could still use the sendfile() interface. If I
would like to implement sendfile() for socket -> [file|socket], would
it be possible to do something like in the following pseudocode:

if srcfd is socket then
	s = sock struct for srcfd
	s->foo_member = dstfd
	s->data_ready = my_data_ready
	block until srcfd is closed

Where foo_member was added by me to the sock struct and my_data_ready
writes to dstfd before calling the default data_ready function. To
follow the sendfile() semantics I should add a max_forward or something
too. Btw, how would I accomplish the block until srcfd is closed, is
it possible (ok, anything is _possible_ but..)?

-- 
Joel Eriksson
