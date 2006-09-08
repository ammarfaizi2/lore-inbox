Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWIHXhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWIHXhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIHXhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 19:37:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:37395 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751287AbWIHXhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 19:37:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=KK3Cxh8LlXOcv/VUHPAWuaC2eigMded6j6ULe+5/q0lcYKHgBMpBGxqvynpFlcFo7xU6gPT9AYhNuCuVPaeE+7W9zvTRKgAOcfnQo72Q5ipSOZwZYkaGERpq1/2ZL6ty3ev/lA1VOSQf5TJeEnjUwpzK6DW+eLnz8DhqHyNveoE=
Message-ID: <728201270609081637n1ac7fd8med69757e224e098a@mail.gmail.com>
Date: Fri, 8 Sep 2006 18:37:19 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "linux mailing-list" <linux-kernel@vger.kernel.org>
Subject: suggestion about rlimit for number of open file descriptions
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     I came across a problem regarding the issue of number of open
file descriptors.The scenario is as below.
 I have a controlling process which launches other different
apllication including third party ones. It also enforces various
resource limits including number of open file descriptors. This
process forks & reads the resource limits from a configuration files,
applies the resource limits & then execs for the corresponding
application. The process has its own various number of open file
descriptors. If the limit of open file descriptor for the child
application is less than the number of file descriptors  of the parent
process, then the child application file can not be opened & exec
fails in this case.

I searched solution for this problem but could not find an existing
way to solve it. I thought of couple of ways to do it. One idea is to
create another flag for clone which makes it not to inherit the open
file descriptors & use clone with that flag instead of fork .The other
approach is to create a new system call & parent process can call that
system call before calling the setrlimit.

I am looking for your opinion which is the better way or if there is
some other better way. Further if this is generic enough issue then I
can submit the patch.

Thanks
Ram Gupta
