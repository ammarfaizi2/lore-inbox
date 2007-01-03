Return-Path: <linux-kernel-owner+w=401wt.eu-S932082AbXACU1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbXACU1E (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 15:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbXACU1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 15:27:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:43622 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084AbXACU06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 15:26:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oCmnBh5SJYw70eXqoIQ2Z0fWjPER1gNLXvew+7up62T7l+VsiWXr7J9R5AmWjhTH77H9ZhNcHkDLV1DIILzJGi4yLzUhf+Ox9ayIPcyEdWnnof9D9MYgaZ9mmUpS0badFOeEw4vvVT9z+DafKDqnu1t0UKRwI/X5RS1U6wXtJlQ=
From: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
Cc: Michael Krufky <mkrufky@linuxtv.org>, linux-kernel@vger.kernel.org,
       Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make shortlog use 'h' (head) parameter again
Date: Wed,  3 Jan 2007 21:30:04 +0100
Message-Id: <11678562042320-git-send-email-jnareb@gmail.com>
X-Mailer: git-send-email 1.4.4.3
In-Reply-To: <459C0232.3090804@linuxtv.org>
References: <459C0232.3090804@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes typo in 190d7fdcf325bb444fa806f09ebbb403a4ae4ee6

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Michael Krufky wrote:

> Ever since gitweb on kernel.org was recently updated, I've been experiencing a
> nasty bug -- It seems that it is no longer possible to view a shortlog from any
> branch or head other than master.
[...]
> "log" and "tree" is working properly -- it seems that "shortlog" is the only
> feature affected by this bug.

This corrects this bug.  When introducing parse_commits to shortlog,
there was typo in parse_commits arguments: it was $head instead of $hash.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2ead917..2179054 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4423,7 +4423,7 @@ sub git_shortlog {
 	}
 	my $refs = git_get_references();
 
-	my @commitlist = parse_commits($head, 101, (100 * $page));
+	my @commitlist = parse_commits($hash, 101, (100 * $page));
 
 	my $paging_nav = format_paging_nav('shortlog', $hash, $head, $page, (100 * ($page+1)));
 	my $next_link = '';
-- 
1.4.4.3

