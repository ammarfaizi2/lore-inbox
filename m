Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316712AbSE3PZw>; Thu, 30 May 2002 11:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSE3PZv>; Thu, 30 May 2002 11:25:51 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:53003 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316712AbSE3PZr>; Thu, 30 May 2002 11:25:47 -0400
Date: Thu, 30 May 2002 17:25:44 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: large copy_to_user fills only one page?
Message-ID: <20020530172544.I681@nightmaster.csn.tu-chemnitz.de>
Reply-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
In-Reply-To: <7wofexu2hl.fsf@avalon.france.sdesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Emmanuel,

On Thu, May 30, 2002 at 04:36:22PM +0200, Emmanuel Michon wrote:
> I'm working with linux-2.4.18, and writing some
> trivial code to get from kernel a grabbed image working this way:
> What I get actually is only 4K filled in userland, but copy_to_user
> returns IMSIZE!

copy_to_user() returns the number of bytes NOT copied.
same for copy_from_user().

This is a common mistake and your code using this functions should
look like this:

if (copy_from_user(to,uptr,size)) {
   return -EFAULT;
}

/* Do some processing */

if (copy_to_user(uptr,from,size)) {
   return -EFAULT;
}


PS: CC'ed linux-kernel, that you will not get 1000 answers ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
