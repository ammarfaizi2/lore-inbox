Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315830AbSEEHlB>; Sun, 5 May 2002 03:41:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315831AbSEEHlA>; Sun, 5 May 2002 03:41:00 -0400
Received: from CPE-203-51-25-114.nsw.bigpond.net.au ([203.51.25.114]:30716
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S315830AbSEEHk7>; Sun, 5 May 2002 03:40:59 -0400
Message-ID: <3CD4E208.181AE989@eyal.emu.id.au>
Date: Sun, 05 May 2002 17:40:56 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8-aa2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa2
In-Reply-To: <2661.1020567877@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 05 May 2002 09:34:25 +1000,
> Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
> >I agree with this. However, since this driver cannot be built, and
> >since the latest modutils will exit badly for unresolved, I strongly
> >believe that the comx driver should not be offered (disable it in
> >the Config.in) until it is fixed - 2.4 being a stable kernel.
> >
> >I had to wrap 'depmod' with a script to ignore failures in order
> >to get through a full build (which includes the kernel plus a few
> >extra modules like NVdriver, dc395, lm_sensors).
> 
> You should not have to wrap depmod.  Standard 2.4.* modutils returns 0
> for unresolved errors, for compatibility with previous behaviour.  You
> have to do depmod -u to get a non-zero return code.  The -u flag was
> added in modutils 2.4.7 and defaults to off.  In modutils 2.5 it will
> default to on, that will break code that relies on the existing
> behaviour.  I will not change modutils default behaviour in 2.4.
> 
> So why is your version of depmod breaking?  Either you are specifying
> -u or your distribution has hacked depmod to default -u to on.  Check
> depmod.c for variable flag_unresolved_error, it should default to 0.

You are right, it is not the unresolved that caused it but the non
ELF objects in there (it used not to care before):

# /sbin/depmod-2.4.15 -ae ; echo $?
depmod: /lib/modules/2.4.19-pre8-aa2/ksyms is not an ELF file
depmod: /lib/modules/2.4.19-pre8-aa2/soundconf is not an ELF file
1

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
