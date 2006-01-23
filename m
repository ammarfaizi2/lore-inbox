Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964791AbWAWQu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964791AbWAWQu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWAWQu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:50:27 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:6555 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964791AbWAWQu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:50:26 -0500
Date: Mon, 23 Jan 2006 08:50:11 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: John Richard Moser <nigelenki@comcast.net>
cc: linux-kernel@vger.kernel.org,
       Ubuntu Users List <ubuntu-users@lists.ubuntu.com>,
       ubuntu-devel <ubuntu-devel@lists.ubuntu.com>,
       autopackage-dev@sunsite.dk
Subject: Re: Need insight on designing a package manager
In-Reply-To: <43D4B358.7050604@comcast.net>
Message-ID: <Pine.LNX.4.62.0601230842420.31110@schroedinger.engr.sgi.com>
References: <43D4B358.7050604@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, John Richard Moser wrote:

> install Sun Java on Debian, I found that clicking "no" on the license
> permenantly alters the system in ways dpkg can't track and roll back,
> assuring you can never try to install the package again.

That is a problem with Sun Java destroying Debians package tracking 
database?

> well; policy plug-ins for SELinux are planned, and "meta-native"
> policies will allow a policy file to have chunks modified based on user
> query.

Replacing scripts with meta information that is interpreted has been 
discussed a few times and I most people involved think this is a good 
thing.

> Plug-ins will also allow for policy extensions, to understand SELinux
> and GrSecurity policy files and how to activate them in the system.
> These policy plug-ins will also translate policies written in a built-in
> meta-policy language to the native format of the target backend.

Something like the triggers in UPM? http://uos.graphe.net/upm.html

> going to handle things is not a good idea.  SQLite was, of course,
> chosen for performance.  Running a full RDBMS like MySQL or PostGreSQL
> is out of the question; embedded MySQL is out because it's not object
> oriented (SQLite lets me sqlite3_open() a database and get a handle to
> use; I can work on 100 db's if I want, all at once).  Evidently the
> MySQL folk don't understand that C can be used for object oriented
> programming; it just doesn't do it in the language, as in C++ or Obj-C.
> 
> This is one dilema point; I don't know all the information to store in
> the database.  I'm working on this; could use some help.

SQLite may still be overkill. Look into the Berkeley DB libraries.

> My current largest dilema is dependency checking.  I want a
> file-interface dependency model, handled by the install module.  This
> means looking for either a program /bin/foo or /usr/bin/foo or "InPath
> foo" (a la autopackage IIRC) and comparing its command line interface;
> or finding a library in the same way and comparing its API.

Uhh. That is going to make this whole thing pretty unclean and puts it on 
the same level of hopelessly unfixable like rpm.
