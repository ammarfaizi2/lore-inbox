Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281029AbRKOUer>; Thu, 15 Nov 2001 15:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKOUei>; Thu, 15 Nov 2001 15:34:38 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:31472 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281029AbRKOUeZ>;
	Thu, 15 Nov 2001 15:34:25 -0500
Date: Thu, 15 Nov 2001 13:34:16 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Jackie Meese <jackie.m@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 32 Groups Maximum in 2.4
Message-ID: <20011115133416.O5739@lynx.no>
Mail-Followup-To: Jackie Meese <jackie.m@vt.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3BF3DF31.4010707@vt.edu> <20011115113953.H5739@lynx.no> <3BF41165.4090206@vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3BF41165.4090206@vt.edu>; from jackie.m@vt.edu on Thu, Nov 15, 2001 at 02:03:01PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 15, 2001  14:03 -0500, Jackie Meese wrote:
> Andreas Dilger wrote:
> > On Nov 15, 2001  10:28 -0500, Jackie Meese wrote:
> >>I've been looking for some time on how to raise the maximum number of 
> >>groups for the 2.4 kernel.  I've discovered how to do this kernel, with 
> >>a discussion a few months ago on this 
> >>list.http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0807.html
> > 
> > Have you considered ACLs instead?  http://acl.bestbits.at/
> > Also available for ext3 (I think reiserfs may also support ACLs, not sure).
> > It might not suit your needs, but maybe it does, and it is a better
> > long-term solution.
> 
> The current backup software used for our servers is one big reason for 
> writing off ACL fairly quickly.  Having to check for compatability on 
> other software we use is another reason this was ruled out.

Actually not.  If you want to save/restore ACLs, you can easily do
something like the following before each backup:

getfacl -R --skip_base > .acl_backup

and if you need to restore ACLs, you to the reverse after a restore:

setacl --restore=.acl_backup

This puts the ACLs into a regular file that any backup system can handle.

The EA/ACL support will _likely_ be put into 2.5, so it will probably
be easier to use this than to always patch to support > 32 groups,
including all of the user tools, etc (which AFAIK is not anywhere on
the radar to go into the stock kernel, especially since it impacts the
fast-path for _every_ process either by making the tast struct bigger,
or requiring an extra dereference to get at a dynamically-allocated
group list).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

