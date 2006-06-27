Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932767AbWF0EsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbWF0EsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbWF0EsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:48:07 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:51163 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S933429AbWF0EmP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:15 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 18/21] [Suspend2] Userspace proc entries.
Date: Tue, 27 Jun 2006 14:42:14 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044212.14883.176.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
References: <20060627044112.14883.55823.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Declare proc entries for the userspace interface.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/ui.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 106 insertions(+), 0 deletions(-)

diff --git a/kernel/power/ui.c b/kernel/power/ui.c
index 3d246e4..4955d5f 100644
--- a/kernel/power/ui.c
+++ b/kernel/power/ui.c
@@ -671,3 +671,109 @@ int suspend_early_boot_message(int messa
 }
 #undef say
 
+/*
+ * User interface specific /proc/suspend entries.
+ */
+
+static struct suspend_proc_data proc_params[] = {
+#ifdef CONFIG_NET
+#ifdef CONFIG_PROC_FS
+	{ .filename			= "default_console_level",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &suspend_default_console_level,
+			  .minimum	= 0,
+#ifdef CONFIG_PM_DEBUG
+			  .maximum	= 7,
+#else
+			  .maximum	= 1,
+#endif
+
+		  }
+	  }
+	},
+
+	{ .filename			= "enable_escape",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_CAN_CANCEL,
+		  }
+	  }
+	},
+
+#ifdef CONFIG_PM_DEBUG
+	{ .filename			= "debug_sections",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &suspend_debug_state,
+			  .minimum	= 0,
+			  .maximum	= 2 << 30,
+		  }
+	  }
+	},
+
+	{ .filename			= "log_everything",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_LOGALL,
+		  }
+	  }
+	},
+	  
+	{ .filename			= "pause_between_steps",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_PAUSE,
+		  }
+	  }
+	},
+#endif
+	{ .filename			= "disable_userui_support",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &userui_ops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  }
+	},
+	{ .filename			= "userui_progress_granularity",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &progress_granularity,
+			.minimum	= 1,
+			.maximum	= 2048,
+		}
+	  }
+	},
+	{ .filename			= "userui_program",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		.string = {
+			.variable	= ui_helper_data.program,
+			.max_length	= 255,
+		}
+	  }
+	}
+#endif
+#endif
+};
+

--
Nigel Cunningham		nigel at suspend2 dot net
