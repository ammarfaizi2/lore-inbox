Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWCVX50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWCVX50 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 18:57:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWCVX50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 18:57:26 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:2036 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932421AbWCVX5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 18:57:25 -0500
Date: Wed, 22 Mar 2006 15:57:21 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Possible NULL pointer dereference in fs/configfs/dir.c
Message-ID: <20060322235721.GF7844@ca-server1.us.oracle.com>
Mail-Followup-To: Eric Sesterhenn <snakebyte@gmx.de>,
	linux-kernel@vger.kernel.org
References: <1143068729.27276.1.camel@alice> <20060322232709.GD7844@ca-server1.us.oracle.com> <1143070614.27446.4.camel@alice>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143070614.27446.4.camel@alice>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 12:36:54AM +0100, Eric Sesterhenn wrote:
> I would then propose the following patch, so the check can be
> removed for people who like small kernels. I dont think gcc notices
> that all callers use non-NULL values and optimizes it away.
> 
> -	if (group && group->default_groups) {
> +	BUG_ON(!group);		/* group == NULL is not allowed */
> +	
> +	if (group->default_groups) {

	This is pretty much what I meant.  Thanks.

Joel
-- 

Life's Little Instruction Book #3

	"Watch a sunrise at least once a year."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
