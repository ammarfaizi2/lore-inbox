Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291776AbSBTLb5>; Wed, 20 Feb 2002 06:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBTLbt>; Wed, 20 Feb 2002 06:31:49 -0500
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:57865 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S291776AbSBTLb3>;
	Wed, 20 Feb 2002 06:31:29 -0500
Date: Wed, 20 Feb 2002 12:31:10 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Joao Guimaraes da Costa <guima@huhepl.harvard.edu>
Cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: e2fsck compatibility problem with 2.4.17?
Message-ID: <20020220113109.GA2876@gondor.com>
In-Reply-To: <3C725D1C.3060001@huhepl.harvard.edu> <20020219141538.G25713@lynx.adilger.int> <3C731460.3060607@huhepl.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C731460.3060607@huhepl.harvard.edu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2002 at 09:13:37PM -0600, Joao Guimaraes da Costa wrote:
> It is also interesting that with kernel 2.4.3, I only get one error from 
> using the "dd" command. The drive makes some noise and then it stops 
> with the error above.
> Under 2.4.17, it seems that it tries harder and I get more errors. The 
> drive stays there making noise. (BTW, the noise is a set of 4 x runck 
> plus 4 x ham! It seems each set corresponds to an error on dmesg.)

Just a guess: 2.4.17 may use a different read-ahead algorithmn than
2.4.3, so while dd is reading only one block (and stops if there is a
failure), 2.4.17 tries to read several blocks at once and writes more
than one error message to the log file.

Note that e2fsck reports an error in the range 32783 - 32791, while dd
on 2.4.3 has problems with 32792. So the (first) bad block may be 32792,
but e2fsck gets an error for a block <=32791.

Question is, why does e2fsck get an error from the kernel when it tries
to read (for example) 32791, the kernel can read 32791 without problems,
but gets a hard drive error for 32792? 

Note that this may be all wrong, I currently do not have the time to
read the kernel source and try to verify it.

Jan

