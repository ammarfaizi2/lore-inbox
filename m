Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRKDTUx>; Sun, 4 Nov 2001 14:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRKDTUp>; Sun, 4 Nov 2001 14:20:45 -0500
Received: from unthought.net ([212.97.129.24]:55256 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S273881AbRKDTUf>;
	Sun, 4 Nov 2001 14:20:35 -0500
Date: Sun, 4 Nov 2001 20:20:34 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104202034.M14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <9s43m9$doh$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <9s43m9$doh$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Nov 04, 2001 at 07:07:53PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 07:07:53PM +0000, Linus Torvalds wrote:
> In article <20011104172742Z16629-26013+37@humbolt.nl.linux.org>,
> Daniel Phillips  <phillips@bonn-fries.net> wrote:
> >On November 4, 2001 05:45 pm, Tim Jansen wrote:
> >> > The dot-proc file is basically a binary encoding of Lisp (or XML), e.g. it
> >> > is a list of elements, wherein an element can itself be a list (or a
> >> 
> >> Why would anybody want a binary encoding? 
> >
> >Because they have a computer?
> 
> That's a stupid argument.
> 
> The computer can parse anything. 
> 
> It's us _humans_ that are limited at parsing. We like text interfaces,
> because that's how we are brought up. We aren't good at binary, and
> we're not good at non-linear, "structured" interfaces.
> 
> In contrast, a program can be taught to parse the ascii files quite
> well, and does not have the inherent limitations we humans have. Sure,
> it has _other_ limitations, but /proc being ASCII is sure as hell not
> one of them.
> 
> In short: /proc is ASCII, and will so remain while I maintain a kernel.
> Anything else is stupid.

I agree that it would be stupid *not* to have an ASCII proc.

But why not make a machine-readable /proc as well ?

> 
> Handling spaces and newlines is easy enough - see the patches from Al
> Viro, for example.

Obviously none of you have parsed something like:

[albatros:joe] $ cat /proc/mdstat 
Personalities : [raid0] [raid1] 
read_ahead 1024 sectors
md0 : active raid1 hdc1[1] hda1[0]
      51264 blocks [2/2] [UU]
      
md1 : active raid1 hdc5[1] hda5[0]
      10240128 blocks [2/2] [UU]
      
md2 : active raid0 hdc7[1] hda6[0]
      6661184 blocks 64k chunks
      
unused devices: <none>
[albatros:joe] $ 

Now this isn't even bad - the fun begins when a resync is running, when
mdstat contains *progress meters* like  "[====>      ] 42%".  While being
nicely readable for a human, this is a parsing nightmare.  Especially
because stuff like this changes over time.

The worst thing is, that you'll often see that your parser isn't strict
enough, and therefore won't fail loudly, but rather "mis-parse" the "GUI"
that somehow got put into /proc.

I think it's great to put these things in /proc, but not having a machine
readable form too is stupid, especially because this could be done with
*no* harm to the existing interface, and with very little code.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
