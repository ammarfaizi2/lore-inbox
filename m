Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbRENXsr>; Mon, 14 May 2001 19:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262583AbRENXsh>; Mon, 14 May 2001 19:48:37 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:33800 "EHLO
	anduin.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S262579AbRENXs1>; Mon, 14 May 2001 19:48:27 -0400
Date: Tue, 15 May 2001 01:43:57 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@transmeta.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010515014357.A7928@gondor.com>
In-Reply-To: <3B003FB0.9D12436A@transmeta.com> <E14zQi4-0001YI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <E14zQi4-0001YI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 14, 2001 at 11:21:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2001 at 11:21:00PM +0100, Alan Cox wrote:
> 	You can make it a string if you like but at the end of the day 
> 	has to be an opaque handle. For constant devices it also has to be
> 	a constant name. Otherwise the /dev file I archived with the corporate
> 	backup system turns out to be a different device when I restore the 
> 	box after a problem and I reformat the wrong disk...

Why can't we configure this in user space? I think of something like
/etc/major-numbers. We could then tell the kernel at module load time what
major number to use for a given driver.

The corporate backup system then only needs to restore /dev and 
/etc/major-numbers at the same time. 

I don't think this is the ideal solution. But it has some nice
properties:

- no policy in kernel. Neither device names nor numbers are hard-coded
- no daemons needed, only some simple startup scripts 
- no special filesystems needed, /dev is simple tar-compatible directory
- everybody can add drivers to his system as he wants, without the need
  to register a number. One entry in a config file is enough
- every single system only needs as many major numbers as there are 
  drivers - so even 256 majors should be enough in most cases. 
  (this may be limited by the fact that the existing numbers should be
  recommended as standard entries in /etc/major-numbers to stay backward
  compatible)

Of course there are disadvantages, the biggest problem I see are drivers
compiled into the kernel. They need to get their major number from the
command line, I think, which is pretty ugly.

Perhaps the above is pure bullshit and my proposal is not working for
serveral reasons. But I think we should try to define our requirements to
the device numbering/naming system, and then find a solution that meats
these requirements - the final reason for choosing one solution should be
a technical one, not personal preference.

Jan

