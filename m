Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273577AbRJIHeq>; Tue, 9 Oct 2001 03:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJIHeh>; Tue, 9 Oct 2001 03:34:37 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:38153 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273515AbRJIHeW>; Tue, 9 Oct 2001 03:34:22 -0400
Date: Tue, 9 Oct 2001 09:34:25 +0200
From: Jan Kara <jack@suse.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Quotactl change
Message-ID: <20011009093425.A13307@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011006150731.C30450@atrey.karlin.mff.cuni.cz> <Pine.GSO.4.21.0110061417260.6465-100000@weyl.math.psu.edu> <20011008203418.A505344@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011008203418.A505344@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> Al - is the attached patch more along the lines of what you
> were after?
> 
> Jan - I think this is actually alot closer to what you were
> talking about when we last discussed this.  Can you see any
> problems from a VFS quota point of view here?  I had to make
> small interface changes to a couple of the dquot.c routines
> to make this simpler/more uniform in places - could you have
> cross-check those for me?
  I see two problems:

1) You changed interface do dquot_sync() - so you should also
   change DQUOT_SYNC() macro in quotaops.h (rename argument) and
   all callers of DQUOT_SYNC() macro...

2) It seems to me that validate_quotactl() will actually never return
   superblock - instead of 'ret = 0;' there should be 'return sb;'
   and that test 'if (ret)' should be removed....


								Honza
