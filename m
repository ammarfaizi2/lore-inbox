Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbTDIT1p (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 15:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbTDIT1p (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 15:27:45 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:41929 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S263698AbTDIT1l (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 15:27:41 -0400
Date: Wed, 9 Apr 2003 15:39:03 -0400
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, mingo@redhat.com, arjanv@redhat.com,
       alan@redhat.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux authentication / credential management
Message-ID: <20030409193903.GA31944@delft.aura.cs.cmu.edu>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	torvalds@transmeta.com, mingo@redhat.com, arjanv@redhat.com,
	alan@redhat.com, viro@math.psu.edu, linux-kernel@vger.kernel.org
References: <3946.1049901134@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3946.1049901134@warthog.warthog>
User-Agent: Mutt/1.5.3i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 04:12:14PM +0100, David Howells wrote:
> The first part of what I'm thinking of is a structure like the
> following that has a Process Authentication Group ID and a list of
> authentication tokens for filesystems such as AFS & NFSv4 kerberos
> keys, NTFS ACLs, SAMBA login details.

PAGs have been proposed over and over again and there is one fundamental
problem, my PAG isn't your PAG.

(although in this specific case, if you're looking at it with the AFS
hat it probably is).

Some people want to have an authentication identifier they can keep
synchronized across a cluster, so they want to be able to set the 'PAG'
to any arbitrary value. However Coda (and AFS) prefer to have something
that just guarantees to be a unique identifier for a group of related
tasks (aka. newpag). Allowing someone to set the pag in this case
nullifies the usefulness of the tag because there is no guarantee that
it is unique. It would be similar to allowing someone to specify their
own process id.

What happened to your 'task ornaments', I figured that that would have
been the best way to tag processes with information and allow individual
filesystems to define their own preferred semantics.

http://www.ussg.iu.edu/hypermail/linux/kernel/0201.3/0480.html


Jan

