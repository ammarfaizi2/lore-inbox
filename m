Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266042AbSKLBkP>; Mon, 11 Nov 2002 20:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266064AbSKLBkP>; Mon, 11 Nov 2002 20:40:15 -0500
Received: from bidu.ime.usp.br ([143.107.45.12]:918 "HELO bidu.ime.usp.br")
	by vger.kernel.org with SMTP id <S266042AbSKLBkO>;
	Mon, 11 Nov 2002 20:40:14 -0500
Date: Mon, 11 Nov 2002 23:46:53 -0200
From: Livio Baldini Soares <livio@ime.usp.br>
To: David =?iso-8859-1?Q?San=E1n?= Baena <davidsanan@teleline.es>
Cc: Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: how to access user space memory from kernel.
Message-ID: <20021112014653.GA17743@ime.usp.br>
Mail-Followup-To: Livio Baldini Soares <livio@ime.usp.br>,
	David =?iso-8859-1?Q?San=E1n?= Baena <davidsanan@teleline.es>,
	Ben Collins <bcollins@debian.org>, linux-kernel@vger.kernel.org
References: <00df01c289d3$52969420$6e9afea9@anabel> <20021111225942.GB522@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021111225942.GB522@phunnypharm.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello David and Ben,

Ben Collins writes:
> On Mon, Nov 11, 2002 at 11:40:19PM +0100, David San?n Baena wrote:
> > Hi. I need to access to user space memory from a kernel module. This module
> > is not a driver, so I would like how can i write and read from/to a variable
> > in a user application from my kernel module?

[...]

> The user space application will have to make a call to the driver
> somehow. Usually this is in the way of an ioctl() on a device that the
> driver has made available to use space. The arguments passed across the
> ioctl are known to your kernel module and userspace app. You could pass
> a pointer to the kernel module which would be userspace memory that the
> driver could copy_to_user some data to.

  Using ioctl()  should work  ok, but it  seems that ioctl  is already
cluttered  as it is.  I did  a little  project once  where I  made the
kernel  dispatch  `upcalls`  to   a  user-space  daemon.  Basically  I
implemented  this  mecanism  stealing   the  idea  from  the  Coda  FS
[http://www.coda.cs.cmu.edu/].

  (Look at fs/coda/psdev.c for the implementation). 

  They  basically  set  up a  new  entry  in  /dev/, and  Venus  (it's
user-space  daemon)  would   poll()/read()/write()  from  the  created
entry. As Ben said you can then write() the pointer to memory you want
to copy.

  But I  have a question  for the gurus  out there. Which is  the most
appropriate  manner of  extending the  kernel for  introduction  of an
interface which only one particular module would use?

  I've heard  that ioctl() is already  too much cluttered.  So are the
common virtual filesystems like  /proc/ and /dev/. And _certainly_ new
syscalls are out of question. 

  If  I recall  correctly  Jeff  Garzik and  Greg  KH have  previously
suggested  that  an  ad hoc  ramfs  based  file  system be  setup  for
interfacing  with  the module/kernel.  But  later  on, Patrick  Mochel
defended the use of sysfs.

  Personally I feel that ad hoc  virtual file system can make things a
living  hell, whereas  a  unified, neatly  named  sysfs could  improve
things (but what do I know, I'm just a kernelnewbie ;).

  So which is it guys? Sysfs or ad hoc ramfs? 

  And I've  googled around for  documentation on sysfs and  have found
almost nothing.  Can someone point  me to some material  (mailing list
posts, docs, etc) regarding sysfs? 

  best regards!

--  
  Livio <livio@ime.usp.br>
