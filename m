Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312134AbSCQWnh>; Sun, 17 Mar 2002 17:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312130AbSCQWn1>; Sun, 17 Mar 2002 17:43:27 -0500
Received: from adsl-66-120-100-11.dsl.sndg02.pacbell.net ([66.120.100.11]:12819
	"HELO glacier.arctrix.com") by vger.kernel.org with SMTP
	id <S312128AbSCQWnN>; Sun, 17 Mar 2002 17:43:13 -0500
Date: Sun, 17 Mar 2002 14:45:32 -0800
From: Neil Schemenauer <nas@python.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: capwrap - grant capabilities to executables
Message-ID: <20020317144532.A18963@glacier.arctrix.com>
In-Reply-To: <20020317121118.A18548@glacier.arctrix.com> <a73548$4t3$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <a73548$4t3$1@cesium.transmeta.com>; from hpa@zytor.com on Sun, Mar 17, 2002 at 02:25:12PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Why not just do this with a small program if you're doing setuid
> anyway?

Nothing is running with root privileges (unless root is executing it).
The SUID bit on the wrapper is just a marker and does not change the
effective uid of the process.  Also, AFAIK, you can't pass capabilities
from one program to another using exec().   I don't completely
understand this stuff yet but fs/exec.c has these lines in the
prepare_binprm() function:

        cap_clear(bprm->cap_inheritable);
        cap_clear(bprm->cap_permitted);
        cap_clear(bprm->cap_effective);

Capabilities are only raised if bprm->e_uid == 0.  So, unless I'm
misunderstand the code, you can't do the same thing with a SUID wrapper.

Thanks for you're comments.

  Neil
