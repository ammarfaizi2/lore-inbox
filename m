Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262042AbRETP1W>; Sun, 20 May 2001 11:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbRETP1C>; Sun, 20 May 2001 11:27:02 -0400
Received: from unthought.net ([212.97.129.24]:12203 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S262036AbRETP06>;
	Sun, 20 May 2001 11:26:58 -0400
Date: Sun, 20 May 2001 17:26:56 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: Abramo Bagnara <abramo@alsa-project.org>,
        Kai Henningsen <kaih@khms.westfalen.de>, linux-kernel@vger.kernel.org
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNum
Message-ID: <20010520172656.A20174@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Alexander Viro <viro@math.psu.edu>,
	Abramo Bagnara <abramo@alsa-project.org>,
	Kai Henningsen <kaih@khms.westfalen.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3B07D519.5184BFA@alsa-project.org> <Pine.GSO.4.21.0105201034090.8940-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0105201034090.8940-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sun, May 20, 2001 at 10:45:07AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 10:45:07AM -0400, Alexander Viro wrote:
> 
> 
> On Sun, 20 May 2001, Abramo Bagnara wrote:
> 
> > > It may have several. Which one?
> > 
> > Can you explain better this?
> 
> Example: console. You want to be able to pass font changes. I'm
> less than sure that putting them on the same channel as, e.g.,
> keyboard mapping changes is a good idea. We can do it, but I don't
> see why it's natural thing to do. Moreover, you already have
> /dev/vcs<n> and /dev/vcsa<n>. Can you explain what's the difference
> between them (per-VC channels) and keyboard mapping (also per-VC)?
> 
> Face it, we _already_ have more than one side band.

Wouldn't it be natural to
  write(fd, <control type>)
  write(fd, <control information)
  read(fd, reply)

Only one control file for all controls a device understands

> 
> Moreover, we have channels that are not tied to a particular device -
> they are for a group of them. Example: setting timings for IDE controller.
> Sure, we can just say "open /dev/hda instead of /dev/hda5", but then we
> are back to the "find related file" problem you tried to avoid.

If the IDE controller is a device we can control, it should have a device
file and a control device file.

Problem solved, AFAICS.

Controlling an IDE controller by writing to a device that's hanging on one
of it's busses is a hack, IMO.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
