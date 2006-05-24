Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbWEXSDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbWEXSDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 14:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWEXSDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 14:03:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:56723 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932408AbWEXSDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 14:03:09 -0400
Subject: Re: [PATCH 3/3] proc: make UTS-related sysctls utsns aware
From: Dave Hansen <haveblue@us.ibm.com>
To: Sam Vilain <sam.vilain@catalyst.net.nz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       "Serge E. Hallyn" <serue@us.ibm.com>, herbert@13thfloor.at, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, xemul@sw.ru,
       Andrew Morton <akpm@osdl.org>, Cedric Le Goater <clg@fr.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20060523012301.13531.12776.stgit@localhost.localdomain>
References: <20060523012300.13531.96685.stgit@localhost.localdomain>
	 <20060523012301.13531.12776.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 24 May 2006 11:02:57 -0700
Message-Id: <1148493777.8658.89.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-23 at 13:23 +1200, Sam Vilain wrote:
> 
> +       /* map the filename to the pointer.  perhaps it would be
> better
> +          to put struct offset pointers in table->data ? */
> +       switch (filp->f_dentry->d_name.name[3]) {
> +               case 'y':  /* ostYpe */
> +                       which = uts_ns->name.sysname;
> +                       break;
> +               case 't':  /* hosTname */
> +                       which = uts_ns->name.nodename;
> +                       break;
> +               case 'e':  /* osrElease */
> +                       which = uts_ns->name.release;
> +                       break;
> +               case 's':  /* verSion */
> +                       which = uts_ns->name.version;
> +                       break;
> +               case 'x':  /* XXX - unreachable */
> +                       which = uts_ns->name.machine;
> +                       break;
> +               case 'a':  /* domAinname */
> +                       which = uts_ns->name.domainname;
> +                       break;
> +               default:
> +                       printk("procfs: impossible uts part '%s'",
> +                              (char*)filp->f_dentry->d_name.name);
> +                       r = -EINVAL;
> +                       goto out;
> +       } 

Why not just switch on the ->ctl_name from the table?  Wouldn't that be
easier?

-- Dave

