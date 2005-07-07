Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbVGGBgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbVGGBgA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVGGBdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:33:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262370AbVGGBdO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:33:14 -0400
From: Steve Grubb <sgrubb@redhat.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Wed, 6 Jul 2005 21:33:05 -0400
User-Agent: KMail/1.7.2
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com> <20050706235008.GA9985@kroah.com>
In-Reply-To: <20050706235008.GA9985@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200507062133.05827.sgrubb@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2005 19:50, Greg KH wrote:
> As inotify works off of open file descriptors, yes, this is true.  But,
> again, if you think this is really important, then why not just work
> with inotify to provide that kind of support to it?

http://marc.theaimsgroup.com/?l=linux-kernel&m=110265021327578&w=2

I think Tim was told not to dig into inotify. A lot of effort has been put 
into testing the code Tim has presented with review from several kernel 
developers (listed in the cc). They too should step up and give their opinion 
on this.

I want to believe questions were asked about this last December when we were 
starting into this effort. I think the conclusion from the inotify people was 
for us to proceed and then when we know what we really want, we can refactor 
should anything be in common.

> I suggest you work together with the inotify developers to hash out your
> differences, as it sounds like you are duplicating a lot of the same
> functionality.

Maybe yes and no. Now that the fs audit code is out, I think we can spot 
commonality. The only common piece that I can think of is just the hook. The 
whole rest of it is different. I hope the inotify people comment on this to 
see if there is indeed something that should be refactored.

> Do you have any documetation or example userspace code that shows how to
> use this auditfs interface you have created?

people.redhat.com/sgrubb/audit

The audit package is currently distributed in Fedora Core 4. The code to use 
Tim's fs audit code is in the user space app, but is waiting for the kernel 
pieces.

There is a man page for auditctl that shows all the options. (fs specific 
options are -wWpk ) To watch /etc/shadow, you would issue:

auditctl -w /etc/shadow -p wa

this will generate events for any update to the file including changes to 
ownership or permissions. We are interested in attribute changes as well. If 
you wanted to watch a file in a chroot directory, you could do this:

auditctl -w /var/chroot/etc/shadow -p wa -k /var/chroot

The audit events would indicate the path from the perspective of the app 
generating the events, but since we added the /var/chroot key, we can see 
that it really came from the chroot dir.

Hope this helps...

-Steve Grubb
