Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271572AbRH1Ptb>; Tue, 28 Aug 2001 11:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271586AbRH1PtV>; Tue, 28 Aug 2001 11:49:21 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:53766 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S271572AbRH1PtK>;
	Tue, 28 Aug 2001 11:49:10 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200108281549.f7SFnPg263571@saturn.cs.uml.edu>
Subject: Re: [PATCH] Ext2FS: SUID on Dir
To: clifford@clifford.at (Clifford Wolf)
Date: Tue, 28 Aug 2001 11:49:25 -0400 (EDT)
Cc: Remy.Card@linux.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108281227280.1127-100000@nerd.clifford.at> from "Clifford Wolf" at Aug 28, 2001 12:52:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clifford Wolf writes:

> As you all know, on Ext2FS Partitions the SGID flag has a special function
> on directories: files within that directories will be owned by the same
> group that also owns the directory - which is useful for creating
> directories which are shared between the members of a group.
>
> But that only makes sense if the umask is set to give full permissions to
> the group (e.g. 007 or 002). Noone would do that if there is a system-wide
> 'users' group - so some distributions add an extra group for every user
> which lets the /etc/group file grow very fast and makes the admins life
> harder ...
>
> The following small patch adds a function to the SUID flag on directories.
> If the SUID flag is set for a diectory, all new files in that directory
> will get the same rights in the group-field as they have in their
> user-field.  So, if one sets both - SUID and SGID - on a directory, it
> will also work with a umask like 022 or 077 and there is no more need for
> an extra group for every user.

It would at least be more logical to have SUID do for user IDs
what SGID does for group IDs. Having SUID muck with group IDs
is pretty ugly.

