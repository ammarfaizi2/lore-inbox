Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292847AbSB0VGJ>; Wed, 27 Feb 2002 16:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292947AbSB0VF0>; Wed, 27 Feb 2002 16:05:26 -0500
Received: from mailhost.nmt.edu ([129.138.4.52]:26130 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S292954AbSB0VEp>;
	Wed, 27 Feb 2002 16:04:45 -0500
Date: Wed, 27 Feb 2002 14:04:32 -0700
From: Val Henson <val@nmt.edu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Laurent <laurent@augias.org>, linux-kernel@vger.kernel.org
Subject: Re: read_proc issue
Message-ID: <20020227140432.L20918@boardwalk>
In-Reply-To: <E16fmE1-0000Mu-00@lsinitam> <Pine.LNX.4.33L2.0202271122040.1463-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0202271122040.1463-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Wed, Feb 27, 2002 at 11:33:18AM -0800
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 11:33:18AM -0800, Randy.Dunlap wrote:
> On Tue, 26 Feb 2002, Laurent wrote:
<snippety snippety>
> | Problem is:
> | when I 'cat /proc/number' multiple times, instead of getting
> | 0
> | 1
> | 2
> | 3
> | ...
> |
> | I get
> | 0
> | 2
> | 4
> | 6
> | ...
<more snippage>
> app. calls read() [Key data: with offset=0], which calls sys_read(),
> which calls proc_file_read(), which returns N bytes, and then
> proc_file_read() and sys_read() and read() return to the app.
> 
> When the app. gets N bytes of actual data on its read(), it
> doesn't know whether it was at EOF or not, so it tries another
> read() [with offset=N], and sys_read() calls proc_file_read()
> again, both of which return 0, so the app. knows that there
> is no more data.

I've encountered this problem before, too.  What is the "One True Way"
to do this cleanly?  In other words, if you want to do a calculation
once every time someone runs "cat /proc/foo", what is the cleanest way
to do that?  The solution we came up with was to check the file offset
and only do the calculation if offset == 0, which seems pretty
hackish.

-VAL
