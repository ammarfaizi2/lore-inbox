Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261691AbVAUB1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261691AbVAUB1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 20:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbVAUB1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 20:27:52 -0500
Received: from opersys.com ([64.40.108.71]:56846 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261691AbVAUB1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 20:27:47 -0500
Message-ID: <41F05D11.5020109@opersys.com>
Date: Thu, 20 Jan 2005 20:38:25 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@muc.de>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>
Subject: Re: [PATCH] relayfs redux for 2.6.10: lean and mean
References: <41EF4E74.2000304@opersys.com> <20050120145046.GF13036@kroah.com>
In-Reply-To: <20050120145046.GF13036@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> Hm, how about this idea for cutting about 500 more lines from the code:
> 
> Why not drop the "fs" part of relayfs and just make the code a set of
> struct file_operations.  That way you could have "relayfs-like" files in
> any ram based file system that is being used.  Then, a user could use
> these fops and assorted interface to create debugfs or even procfs files
> using this type of interface.
> 
> As relayfs really is almost the same (conceptually wise) as debugfs as
> far as concept of what kinds of files will be in there (nothing anyone
> would ever rely on for normal operations, but for debugging only) this
> keeps users and developers from having to spread their debugging and
> instrumenting files from accross two different file systems.

However this assumes that the users of relayfs are not going to want
it during normal system operation. This is an assumption that fails
with at least LTT as it is targeted at sysadmins, application developers
and power users who need to be able to trace their systems at any time.

I don't mind piggy-backing off another fs, if it makes sense, but
unlike debugfs, relayfs is meant for general use, and all files in there
are of the same type: relay channels for dumping huge amounts of data
to user-space. It seems to me the target audience and basic idea (relay
channels only in the fs) are different, but let me know if there's a
compeling argument for doing this in another way without making it too
confusing for users of those special "files" (IOW, when this starts
being used in distros, it'll be more straightforward for users to
understand if all files in a mounted fs behave a certain way than if
they have certain "odd" files in certain directories, even if it's
/proc.)

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
