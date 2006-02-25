Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWBYQzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWBYQzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 11:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBYQzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 11:55:00 -0500
Received: from mail.clusterfs.com ([206.168.112.78]:65222 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S932154AbWBYQzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 11:55:00 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17408.35811.419079.574238@gargle.gargle.HOWL>
Date: Sat, 25 Feb 2006 19:54:59 +0300
To: Steven Whitehouse <swhiteho@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GFS2 Filesystem [14/16]
Newsgroups: gmane.linux.kernel
In-Reply-To: <1140793580.6400.736.camel@quoit.chygwyn.com>
References: <1140793580.6400.736.camel@quoit.chygwyn.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Whitehouse writes:
 > [PATCH 14/16] GFS2: 
 > 

[...]

 > +
 > +int gdlm_kobject_setup(struct gdlm_ls *ls, struct kobject *fskobj)
 > +{
 > +	int error;
 > +
 > +	error = kobject_set_name(&ls->kobj, "%s", "lock_module");
 > +	if (error) {
 > +		log_error("can't set kobj name %d", error);
 > +		return error;
 > +	}
 > +
 > +	ls->kobj.kset = &gdlm_kset;
 > +	ls->kobj.ktype = &gdlm_ktype;
 > +	ls->kobj.parent = fskobj;
 > +
 > +	error = kobject_register(&ls->kobj);

What prevents races between file system umount (and file system module
unloading) and invocations of ->show/->store? This used to be a
show-stopper for exporting file system attributes in sysfs.

Nikita.
