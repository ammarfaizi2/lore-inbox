Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbUDHRmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUDHRmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:42:33 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:11921 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262005AbUDHRmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:42:31 -0400
Subject: Re: setgid - its current use
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: gami@d10systems.com
Content-Type: text/plain
Organization: 
Message-Id: <1081446055.1587.172.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 08 Apr 2004 13:40:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dhruv Gami writes:
> On Thu, 8 Apr 2004, Denis Vlasenko wrote:
>> On Thursday 08 April 2004 04:46, Dhruv Gami wrote:

>>> I'd like to know the possibility of using setgid for users
>>> to switch their groups and work as a member of a particular
>>> group. Essentially, if i want one user, who belongs to
>>> groups X, Y and Z to create a file as a member of group Y
>>> while he's logged on as a member of group X, would it be
>>> possible through setgid() ?
>>
>> it is possible through chmod
>
> but that would be an explicit way of doing it, right ?
> I'm looking for doing this via some system calls or something
> transparent to the user. At  most I'd like to query the user
> for the group as which he wants to work. Which would
> essentially be a question I ask at login or beginning of a 
> session.

I think you need user-private groups and setgid directories.

First of all, ensure that each user has a group of
their own. Do NOT put all users into a "users" group.
So user "gami" would be in group "gami", or maybe
a "gami_group" group if you prefer. Have the home
directories owned by these groups.

Second, set the umask to allow group write access.
(this is why you need the user-private groups)

Now suppose you have two users, bill and tom,
who need to work together on the spamming project.
Create a group called "spamming". Create a project
directory /projects/spamming owned by root and
in the spamming group. Make this directory setgid
and group writable. Any files created in this
directory will be owned by the spamming group.
Due to the umask setting, permissions on these
new files will allow access by all group members.
The setgid bit will propagate to any newly created
directories, but not to newly created files.


