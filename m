Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289671AbSAJUxV>; Thu, 10 Jan 2002 15:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289672AbSAJUxL>; Thu, 10 Jan 2002 15:53:11 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:50165 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S289405AbSAJUxE>; Thu, 10 Jan 2002 15:53:04 -0500
Date: Thu, 10 Jan 2002 12:56:48 -0800
From: Chris Wright <chris@wirex.com>
To: Senhua Tao <stao@nbnet.nb.ca>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        linux-kernel@vger.kernel.org
Subject: Re: absolute path of a process (as the credential of a process)
Message-ID: <20020110125648.A1412@figure1.int.wirex.com>
Mail-Followup-To: Senhua Tao <stao@nbnet.nb.ca>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C3DB937.A7E36933@nbnet.nb.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3DB937.A7E36933@nbnet.nb.ca>; from stao@nbnet.nb.ca on Thu, Jan 10, 2002 at 11:54:31AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Senhua Tao (stao@nbnet.nb.ca) wrote:

<some details snipped>

> The ip filter checking can be done in sys_connect(). That is the problem
> that I am having. I try to get the absolute path of the current process
> which calls connect() to against the entries in the config file (they
> also have to be translated to absolute path) and get lost.

if you look at the code in fs/proc/base.c::proc_exe_link() you can
see how the absolute pathname is gathered (note: only on execve is the
VM_EXECUTABLE flag set).  basically you need the dentry and vfsmount
of the file.  btw, you are only stopping tcp and bound udp if you hook
in sys_connect, perhaps you should consider the sendmsg family as well.
also, if the trojan is a server you have not protected listen/accept or
resvmsg so sys_socket may be the best spot to watch.

also, all of this can be done using the LSM framework.  (see lsm.immunix.org
for patches).

cheers,
-chris
