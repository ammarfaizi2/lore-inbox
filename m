Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWIVKDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWIVKDU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWIVKDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:03:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:9488 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932122AbWIVKDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:03:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=jD6X2cwIAmHTBwYun2sXg3D2y2qosW7dQbzv8DwJ+3zJPvwmEgQzeX7P/srID7eRa8Xx1Rd9dt9g4w8rUfyG6F7TRLvD8hsSZDc4Z9hXy5UsG92ZWMvvUaZvkMjhzVHQJALx8FHGuNlNQkVLYdOBkogqtWpnEm4YSThbAl7ZiSM=
Date: Fri, 22 Sep 2006 12:02:10 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org
Subject: Make kernel -dirty naming optional
Message-ID: <20060922120210.GA957@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Could you consider applying this patch (or indicate me a better way to
do it). It can be handy to be able to keep the naming independent of
git.

Thanks,
Frederik



diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 82e4993..62f2fef 100644
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -9,7 +9,7 @@ usage() {
 cd "${1:-.}" || usage
 
 # Check for git and a git repo.
-if head=`git rev-parse --verify HEAD 2>/dev/null`; then
+if [ -z "${IGNORE_GIT}" ] && head=`git rev-parse --verify HEAD 2>/dev/null`; then
 	# Do we have an untagged version?
 	if git name-rev --tags HEAD | grep -E '^HEAD[[:space:]]+(.*~[0-9]*|undefined)$' > /dev/null; then
 		printf '%s%s' -g `echo "$head" | cut -c1-8`

