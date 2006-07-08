Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964784AbWGHMnr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964784AbWGHMnr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 08:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWGHMnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 08:43:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51869 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964784AbWGHMnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 08:43:46 -0400
Date: Sat, 8 Jul 2006 14:43:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>
Subject: [patch] fix boot with acpi=off
Message-ID: <20060708124330.GA1577@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With acpi=off and acpi_ac/battery compiled into kernel, acpi breaks
boot. This fixes it.

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 30b8ecda788b096fbd7088808f9af65c41c3a83d
tree 3c28088018932f9ceb18bcf980507474d4a50c4e
parent 05f70501240c6ad5f852f13c187ee55579ad7bb8
author <pavel@amd.ucw.cz> Sat, 08 Jul 2006 14:43:13 +0200
committer <pavel@amd.ucw.cz> Sat, 08 Jul 2006 14:43:13 +0200

 drivers/acpi/ac.c      |    2 ++
 drivers/acpi/battery.c |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 24ccf81..432b6b7 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -285,6 +285,8 @@ static int __init acpi_ac_init(void)
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
 
 	acpi_ac_dir = acpi_lock_ac_dir();
 	if (!acpi_ac_dir)
diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2ce9b35..5af1f64 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -764,6 +764,9 @@ static int __init acpi_battery_init(void
 {
 	int result;
 
+	if (acpi_disabled)
+		return -ENODEV;
+
 	acpi_battery_dir = acpi_lock_battery_dir();
 	if (!acpi_battery_dir)
 		return -ENODEV;

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
