Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRKDScW>; Sun, 4 Nov 2001 13:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281069AbRKDScM>; Sun, 4 Nov 2001 13:32:12 -0500
Received: from unthought.net ([212.97.129.24]:49880 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S281086AbRKDSbk>;
	Sun, 4 Nov 2001 13:31:40 -0500
Date: Sun, 4 Nov 2001 19:31:34 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: John Levon <moz@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org, Daniel Phillips <phillips@bonn-fries.net>,
        Tim Jansen <tim@tjansen.de>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011104193134.G14001@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
	Daniel Phillips <phillips@bonn-fries.net>,
	Tim Jansen <tim@tjansen.de>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104163354.C14001@unthought.net> <160QM5-1HAz5sC@fmrl00.sul.t-online.com> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <20011104184159.E14001@unthought.net> <20011104175945.A91628@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20011104175945.A91628@compsoc.man.ac.uk>; from moz@compsoc.man.ac.uk on Sun, Nov 04, 2001 at 05:59:45PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2001 at 05:59:45PM +0000, John Levon wrote:
> On Sun, Nov 04, 2001 at 06:41:59PM +0100, Jakob Østergaard wrote:
> 
> > The "fuzzy parsing" userland has to do today to get useful information
> > out of many proc files today is not nice at all.  It eats CPU, it's 
> > error-prone, and all in all it's just "wrong".
> 
> This is because the files are human-readable, nothing to do with binary vs. plain
> text. proc should be made (entirely ?) of value-per-file trees, and a back-compat
> compatprocfs union mounted for the files people and programs are expecting.

So you want generaiton and parsing of text strings whenever we pass an int from
the kernel ?

> 
> > However - having a human-readable /proc that you can use directly with
> > cat, echo,  your scripts,  simple programs using read(), etc.   is absolutely
> > a *very* cool feature that I don't want to let go.  It is just too damn
> > practical.
> 
> I don't see that it's at all useful: it just makes life harder. You yourself
> state above that read(2) parsing of human readable files is "not nice at all",
> and now you're saying it is "just too damn practical".

cat /proc/mdstat    - that's practical !
cat /proc/cpuinfo   - equally so

Anyway - I won't involve myself in the argument whether we should keep
the old /proc or not - I wanted to present my idea how we could overcome
some fundamental problems in the existing framework,  non-intrusively.

> 
> Just drop the human-readable stuff from the new /proc, please.

I don't care enough about it to discuss it now, but I'm sure others do  ;)

> 
> In what way is parsing /proc/meminfo in a script more practical than 
> cat /proc/meminfo/total ?

I see your point.

There's some system overhead when converting text/integer values, but
if you're polling so often I guess you have other problems anyway...

...
> 
> This just seems needless duplication, and fragile. Representing things as directory
> hierarchies and single-value files in text seems to me to be much nicer, just as
> convenient, and much nicer for fs/proc/ source...

I like the idea of single-value files.

But then how do we get the nice summary information we have today ?

Hmm...   How about:

  /proc/meminfo    - as it was
  /proc/.meminfo/  - as you suggested

That way we keep /proc looking like it was, while offering the very nice
single-value file interface to apps that needs it.

I could even live with text encoding of the values - I just hate not being able
to tell if it's supposed to be i32/u32/i64/u64/float/double/...  from looking
at the variable.   Type-less interfaces with implicitly typed values are
*evil*.

I'd love to have type information passed along with the value.   Of course
you could add a "f"_t file for each "f", and handle eventual discrepancies
at run-time in your application.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
