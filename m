Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264498AbSIQSpC>; Tue, 17 Sep 2002 14:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264500AbSIQSpC>; Tue, 17 Sep 2002 14:45:02 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:20894
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S264498AbSIQSo7>; Tue, 17 Sep 2002 14:44:59 -0400
Date: Tue, 17 Sep 2002 11:49:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] Cleanup (BIN|BCD)_TO_(BCD|BIN) usage/macros
Message-ID: <20020917184949.GB726@opus.bloom.county>
References: <20020917182950.GA726@opus.bloom.county> <3D8776FF.3050504@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8776FF.3050504@mandrakesoft.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 02:39:59PM -0400, Jeff Garzik wrote:
> Tom Rini wrote:
> >Right now there's a bit of a mess with all of the BIN_TO_BCD/BCD_TO_BIN
> >macros in the kernel.  It's defined in a half dozen places, and worse
> >yet, not all places use them the same way.  Most users do something
> >like:
> >if ( ... )
> >   BIN_TO_BCD(x);
> >
> >But in a few places, it's used as:
> >if ( ... )
> >   y = BIN_TO_BCD(x);
> >
> >The following creates include/linux/bcd.h which has the 'normal'
> >BIN_TO_BCD macros, as well as CONVERT_{BIN,BCD}_TO_{BCD,BIN},
> >which are for the second case.
> 
> hmmm... removing all the private definitions certainly makes good sense, 
> but having both CONVERT_foo and foo seems a bit wonky...
> 
> IMO it would be better to have BIN_TO_BCD which returns a value, and 
> __BIN_TO_BCD which has side effects but returns no value...

Well, this was done in part to minimize change.  The version which
returns no value is far more common than the one which does, and would
require changing a lot more files (and would also make getting this into
2.4 harder too, which I would like to do someday if this gets into 2.5). 
The other reason is that CONVERT_foo makes it quite obvious what is being
done, where as __xxx at least in my mind has namespace imlpications
(like how it's used in libc, etc.  But kernel namespace isn't like the
rest I know..).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
