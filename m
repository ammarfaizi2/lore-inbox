Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135762AbRAJPMH>; Wed, 10 Jan 2001 10:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135801AbRAJPL4>; Wed, 10 Jan 2001 10:11:56 -0500
Received: from unthought.net ([212.97.129.24]:15019 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S135762AbRAJPLs>;
	Wed, 10 Jan 2001 10:11:48 -0500
Date: Wed, 10 Jan 2001 16:11:46 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: antirez <antirez@invece.org>
Cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: * 4 converted to << 2 for networking code
Message-ID: <20010110161146.A3252@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	antirez <antirez@invece.org>, Brian Gerst <bgerst@didntduck.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010110174859.R7498@prosa.it> <3A5C778C.CFB363F3@didntduck.org> <20010110180322.T7498@prosa.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20010110180322.T7498@prosa.it>; from antirez@invece.org on Wed, Jan 10, 2001 at 06:03:22PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 06:03:22PM +0100, antirez wrote:
> On Wed, Jan 10, 2001 at 09:54:04AM -0500, Brian Gerst wrote:
> > This patch isn't really necessary, because GCC will automatically
> > convert multiplications and divisions by powers of two to use shifts.
> 
> Sure, but since many << 2 already exists in the net kernel code
> I feel it's better to use just a format, and it seems more appropriate
> to write << 2, just to reflect what we want.
> Also some piece of kernel code may be used with compilers that does not
> optimize power of two.

On most processors <<2 is slower than *4.   It's outright stupid to 
write <<2 when we mean *4 in order to optimize for one out of a
gazillion supported architectures - even more so when the compiler
for the one CPU where <<2 is faster, will actually generate a shift
instead of a multiply as a part of the standard optimization.

One question for the GCC people:  Will gcc change <<2 to *4 on other 
architectures ?    If so, then my case is not quite as strong of course.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
