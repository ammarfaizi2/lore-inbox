Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSJWCfO>; Tue, 22 Oct 2002 22:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJWCfO>; Tue, 22 Oct 2002 22:35:14 -0400
Received: from h24-87-160-169.vn.shawcable.net ([24.87.160.169]:51328 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S262702AbSJWCfO>;
	Tue, 22 Oct 2002 22:35:14 -0400
Date: Tue, 22 Oct 2002 19:41:22 -0700
From: Simon Kirby <sim@netnation.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jesse Pollard <pollard@admin.navo.hpc.mil>
Cc: Tim Hockin <thockin@sun.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Message-ID: <20021023024122.GA2205@netnation.com>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <1035308740.31873.107.camel@irongate.swansea.linux.org.uk> <3DB58CBD.3030207@sun.com> <200210221303.47488.pollard@admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210221303.47488.pollard@admin.navo.hpc.mil>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:03:47PM -0500, Jesse Pollard wrote:

> And I really doubt that anybody has 10000 unique groups (or even
> close to that) running under any system. The center I'm at has
> some of the largest UNIX systems ever made, and there are only
> about 600 unique groups over the entire center. The largest number
> of groups a user can be in is 32. And nobody even comes close.

It happens.  We have a bunch of webservers with the web user in thousands
of groups, and we ran into the per-process limit a long, long time ago. 
My solution was a bit simpler, however:

 static int supplemental_group_member(gid_t grp)
 {
        int i = current->ngroups;
 
+       if (current->uid == 80)
+               if (grp >= 1000)
+                       return 1;

O:)

This allows us to have a group-per-user policy where the web server has
access to each user's files without allowing any user to have access to
files belonging to any other user, which is quite useful.

Simon-

[        Simon Kirby        ][        Network Operations        ]
[     sim@netnation.com     ][     NetNation Communications     ]
[  Opinions expressed are not necessarily those of my employer. ]
