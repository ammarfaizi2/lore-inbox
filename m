Return-Path: <linux-kernel-owner+w=401wt.eu-S1752796AbWLOQIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796AbWLOQIg (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752797AbWLOQIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:08:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:54831 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796AbWLOQIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:08:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=By9zmpeqIhaQa/htsHkstGBEyXggWF3h85mAfXXn9+VlCvztdS+jmyTfWfTO1a+C0AF+nex5GgbaMyfylTCaicWyVEfgqhRplhTGRQuAZLrXmyYie16O7Qm+hgW1N232Eta72aQaF6C9ZERVk9vdbHqUYYQO8wBKJboeyfywnoI=
Message-ID: <a2ebde260612150808y20c61f30t584ceaa5e2dcdcf4@mail.gmail.com>
Date: Sat, 16 Dec 2006 00:08:33 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Redundent Parameter or Inconsistent Hardcoding
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Function permanent_kmaps_init() take a struct pgd_t as parameter.

I presume passing the struct pgd_t as a parameter is to make the
function flexible in order to reuse it under different cases. However,
I discover the following things imparing the rationality of this
parameter.

1. This function is invoke from one place only. That is, in
pagetable_init(), where swapper_pg_dir is passed as the parameter.

2. The function accesses swapper_pg_dir directly.

So I think either the parameter is redundent or the direct hardcoded
access to swapper_pg_dir within the function should be replaced by the
access to the parameter.
