Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266835AbUHOSAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266835AbUHOSAy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266837AbUHOSAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 14:00:50 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:55116 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266835AbUHOSAq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 14:00:46 -0400
Date: Sun, 15 Aug 2004 20:03:20 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bernd Eckenfels <be-mail2004@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove obsolete HEAD in top Makefile
Message-ID: <20040815180320.GD7265@mars.ravnborg.org>
Mail-Followup-To: Bernd Eckenfels <be-mail2004@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <E1BwJne-0006M7-00@calista.eckenfels.6bone.ka-ip.net> <411F58DF.2070002@greatcn.org> <20040815141342.GB30572@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815141342.GB30572@lina.inka.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 04:13:42PM +0200, Bernd Eckenfels wrote:
> On Sun, Aug 15, 2004 at 08:36:47PM +0800, Coywolf Qi Hunt wrote:
> > >iff it is not using it you need to remove it in the next line, too.
> > Nah, I'm only removing HEAD, not head-y. :p
> 
> If you remove this line:
> head-y += $(HEAD)
> 
> then head-y is undefined, and could therefore be removed, too. I dont know
> what HEAD was used for, and where does it come from. But since the 2.4 code
> uses head in a compareable way (i.e. only in that location with toetally
> differen s tructure) I am not sure if it is not needed.
> 
> Can you explain what it was used for and why it can be removed now?
HEAD got replaced with head-y sometime in 2.5.
It's about time to rip out the last bits.

About head-y:
>From Documentation/kbuild/makefiles.txt:

   The very first objects linked are listed in head-y, assigned by
      arch/$(ARCH)/Makefile.

And later:

    head-y, init-y, core-y, libs-y, drivers-y, net-y

            $(head-y) list objects to be linked first in vmlinux.
            $(libs-y) list directories where a lib.a archive can be located.
            The rest list directories where a built-in.o object file can be located.
	    
            $(init-y) objects will be located after $(head-y).
            Then the rest follows in this order:
            $(core-y), $(libs-y), $(drivers-y) and $(net-y).
						    

	Sam
