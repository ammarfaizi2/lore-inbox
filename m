Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264225AbTDJWBb (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 18:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbTDJWBb (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 18:01:31 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:15354 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264225AbTDJWB3 (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 18:01:29 -0400
Date: Thu, 10 Apr 2003 16:06:36 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel support for non-english user messages
Message-ID: <20030410160636.H26054@schatzie.adilger.int>
Mail-Followup-To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
	'Chuck Ebbert' <76306.1226@compuserve.com>,
	'linux-kernel' <linux-kernel@vger.kernel.org>
References: <A46BBDB345A7D5118EC90002A5072C780BEBA7DD@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780BEBA7DD@orsmsx116.jf.intel.com>; from inaky.perez-gonzalez@intel.com on Thu, Apr 10, 2003 at 02:20:54PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2003  14:20 -0700, Perez-Gonzalez, Inaky wrote:
> > From: Chuck Ebbert [mailto:76306.1226@compuserve.com]
> > >>      How about changing the way printk works, so that instead of
> > >> combining the format string, it just "prints" its args:
> > >>
> > >> printk("%s: name %p is %d\n", name, ptr, val);
> > >>
> > >> results in the following in the kernel buffer:
> > >>
> > >> "%s: name %p is %d\n", "stringval", 0x4790243, 44
> > >
> > > Debugging a non-klogd enabled kernel would be a pain
> > 
> > 
> >  Why?  Shouldn't it be easy to fix dmesg so it unmangles the output?
> 
> s/non-klogd enabled/dmesg/
> 
> Same thing - what I mean is that if you don't have some automatic
> means to recompose the messages, reading the direct output of 
> the console (as sometimes you have to), becomes a mess.

  From what I've read, it sounds like the solution that will be accepted by
the kernel developers is that kernel messages will continue to be output
as-is in english, and can be post-processed with a tool to translate it to
another language.  The tool will grab the format strings from the kernel
so that it can separate out the constant and variable parts of the message,
and the format strings will be translated.

At translation time, _something_ _like_ "sscanf(format_string, ...)" will
be used to detect the which message is which (probably being speeded up
with a pattern-matching hash of the constant parts of the message like
prcs/xdelta does), substituting the english format with the translated
format, and then substituting the args.

This has the benefit that it can be used in klogd/dmesg/ksymoops, or even
as a standalone tool for filtering kernel messages in email or over a
serial console, and you can also get multiple translations instead of
just the one that was output to the screen.

Cheers, Andreas

PS: 2.4.18 has 51217 printks, 2.5.recent has 59728.  Some of them don't need
    to be translated, some of them are hidden inside macros.  In any case,
    there is a lot of actual translation that needs to be done to make this
    practical regardless of what the details are.
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

