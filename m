Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316893AbSF1IIO>; Fri, 28 Jun 2002 04:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317025AbSF1IIN>; Fri, 28 Jun 2002 04:08:13 -0400
Received: from mail3.alphalink.com.au ([202.161.124.59]:13635 "EHLO
	mail3.alphalink.com.au") by vger.kernel.org with ESMTP
	id <S316893AbSF1IIM>; Fri, 28 Jun 2002 04:08:12 -0400
Message-ID: <3D1C1951.987E1FF8@alphalink.com.au>
Date: Fri, 28 Jun 2002 18:07:45 +1000
From: Greg Banks <gnb@alphalink.com.au>
Organization: Corpus Canem Pty Ltd
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, mec@shout.net,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] [PATCH] kconfig: menuconfig and config uses $objtree
References: <20020628001452.A14485@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> 
> In order to prepare for separate obj and src trees make use of $objtree
> within scripts/Menuconfig and scripts/Configure.
> All temporary and all result files are located in directory pointed at
> by $objtree.
> 
> This functionality is foreseen useful for both current kbuild and kbuild-2.5

Interesting, but there's an alternative approach.  Let the scripts dump
any files they like into the current directory, but move the current
directory to be the *object* directory not the source directory.  Then
all you need to change are the places where the arch config.in files are
initially included, and to override the "source" statement to look relative
to $srctree not the current directory.  That last can be done like this:

xsource ()
{
    builtin source $srctree/$1
}
shopt -s expand_aliases
alias source=xsource

So the scripts do not even need to know about object directory and source
directory, they only need to know that there is a source directory which
can be separate from the current directory.  This behaviour is closer to
the way autoconf behaves with a separate object directory.

Greg.
-- 
the price of civilisation today is a courageous willingness to prevail,
with force, if necessary, against whatever vicious and uncomprehending
enemies try to strike it down.	   - Roger Sandall, The Age, 28Sep2001.
